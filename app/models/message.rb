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
#
class Message < ApplicationRecord
  belongs_to :from_network, class_name: 'Pug::Network', foreign_key: 'from_network_id'
  belongs_to :to_network, class_name: 'Pug::Network', foreign_key: 'to_network_id'

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

  def identifier
    "#{from_network.name}_#{to_network.name}_#{index}"
  end

  def direction
    "#{from_network.name.camelize}-#{to_network.name.camelize}"
  end

  def root_prepared?
    latest_aggregated = Pug::SubApiAggregatedOrmpDatum.where(pug_network: to_network).order(timestamp: :desc).first
    return false if latest_aggregated.nil?

    block_number <= latest_aggregated.evm_log.block_number
  end
end
