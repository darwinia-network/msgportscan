# == Schema Information
#
# Table name: messages
#
#  id                        :bigint           not null, primary key
#  index                     :integer
#  msg_hash                  :string
#  root                      :string
#  channel                   :string
#  from_chain_id             :integer
#  from                      :string
#  to_chain_id               :integer
#  to                        :string
#  block_number              :integer
#  block_timestamp           :integer
#  transaction_hash          :string
#  status                    :integer
#  encoded                   :text
#  from_network_id           :integer
#  to_network_id             :integer
#  dispatch_transaction_hash :string
#  dispatch_block_number     :integer
#  dispatch_block_timestamp  :integer
#  clear_transaction_hash    :string
#  clear_block_number        :integer
#  clear_block_timestamp     :integer
#  proof                     :json
#  msgport_payload           :text
#  msgport_from              :string
#  msgport_to                :string
#
class Message < ApplicationRecord
  belongs_to :from_network, class_name: 'Pug::Network', foreign_key: 'from_network_id'
  belongs_to :to_network, class_name: 'Pug::Network', foreign_key: 'to_network_id'
  belongs_to :from_contract, class_name: 'Pug::EvmContract', foreign_key: 'from', primary_key: 'address', optional: true
  belongs_to :to_contract, class_name: 'Pug::EvmContract', foreign_key: 'to', primary_key: 'address', optional: true

  # dispatch will have 2 status: dispatched and success, dispatched but failed
  enum status: { accepted: 0, root_ready: 1, dispatch_success: 2, dispatch_failed: 3, cleared: 4 }

  def status_label
    if status == 'accepted'
      'Pending(Accepted)'
    elsif status == 'root_ready'
      'Pending(Root Aggregated)'
    elsif status == 'dispatch_success'
      'Success'
    elsif status == 'dispatch_failed'
      'Failed'
    elsif status == 'cleared'
      'Cleared'
    else
      'Unknown'
    end
  end

  after_create_commit :extract_msgport_payload

  # https://sepolia.arbiscan.io/tx/0xb1bd91053e0cfb86121ad7d04a1ed93c841d9eaa877ee6ca6bb1280ccc47ce46
  #
  # https://github.com/darwinia-network/darwinia-msgport/blob/6f751cf02f2ea0fbb2de401cd3cf07cca68e1b49/src/lines/ORMPLine.sol#L64
  # recv(address,address,bytes)
  # 0x394d1bca
  #   0000000000000000000000009f33a4809aa708d7a399fedba514e0a0d15efa85 <- `source EA` address
  #   000000000000000000000000422df988fda9c7bac5750ee9ea6a46d7a024e99e <- `target EA` address
  #   0000000000000000000000000000000000000000000000000000000000000060
  #   0000000000000000000000000000000000000000000000000000000000000064
  #   d8e6817200000000000000000000000000000000000000000000000000000000 <- the message sent to `target EA`
  #   0000002000000000000000000000000000000000000000000000000000000000
  #   0000000212340000000000000000000000000000000000000000000000000000
  #   0000000000000000000000000000000000000000000000000000000000000000
  #   0e3bede4f813af49d539dba8bf19f49386acd6670a5ffea93814d7a5ce5291c2
  #   000000000000000000000000000000000000000000000000000000000000002c
  #   001ddfd752a071964fe15c2386ec1811963d00c2
  def extract_msgport_payload
    # extract msgport payload if it is a msgport message
    return unless encoded.start_with?('0x394d1bca')

    self.msgport_from = '0x' + encoded[34..73]
    self.msgport_to = '0x' + encoded[98..137]
    self.msgport_payload = '0x' + encoded[266..]
    save!
  end

  def identifier
    "#{from_network.name}_#{to_network.name}_#{index}"
  end

  def direction
    "#{from_network.name}->#{to_network.name}"
  end

  after_create_commit do
    broadcast_prepend_to(
      'messages',
      target: 'messages',
      partial: 'messages/message',
      locals: { message: self }
    )
    broadcast_replace_to(
      'messages_count',
      target: 'messages_count',
      partial: 'messages/messages_count',
      locals: { messages_count: Message.count }
    )
  end

  after_update_commit do
    broadcast_replace_to(
      'messages',
      target: "message_#{identifier}",
      partial: 'messages/message',
      locals: { message: self }
    )
    broadcast_replace_to(
      'message',
      target: "message_#{identifier}",
      partial: 'messages/show_message',
      locals: { message: self }
    )
  end

  # join query example:
  # message_of_root = Message.joins("INNER JOIN pug_sub_api_aggregated_ormp_data ON messages.root = pug_sub_api_aggregated_ormp_data.ormp_data_root")
  #   .where("pug_sub_api_aggregated_ormp_data.pug_network_id = ?", to_network.id)
  #   .order("pug_sub_api_aggregated_ormp_data.timestamp DESC")
  #   .first
  def root_prepared?
    latest_aggregated = Pug::SubApiAggregatedOrmpDatum.where(pug_network: to_network).order(timestamp: :desc).first
    return false if latest_aggregated.nil?

    message_of_root = Message.find_by_root(latest_aggregated.ormp_data_root)
    return false if message_of_root.nil?

    block_number <= message_of_root.block_number
  end
end
