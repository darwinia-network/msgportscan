namespace :messages do
  desc 'Start tracing messages'
  task trace: :environment do
    $stdout.sync = true
    chain_ids = Rails.application.config.ormpscan2['chains']
    networks = Pug::Network.where(chain_id: chain_ids)

    loop do
      puts '= SYNCRONIZING ==============================='
      puts 'sync new accepted messages'
      networks.each do |network|
        sync_accepted_messages(network)
      end

      puts 'check accepted messages'
      check_accepted_messages(networks)

      puts 'check root ready messages'
      check_root_ready_messages(networks)

      puts "\n"
      sleep 10
    rescue StandardError => e
      puts e
      puts e.backtrace.join("\n")

      sleep 10
    end
  end
end

# root_ready -> dispatch_success/dispatch_failed
def check_root_ready_messages(networks)
  messages = Message.where(from_network: networks, to_network: networks, status: :root_ready)
  messages.each do |message|
    dispatched_log = Pug::EvmLog.with_event('MessageDispatched')
                                .field_eq('msg_hash', message.msg_hash)
                                .first
    next if dispatched_log.nil?

    message.dispatch_transaction_hash = dispatched_log.transaction_hash
    message.dispatch_block_number = dispatched_log.block_number
    message.dispatch_block_timestamp = dispatched_log.timestamp
    message.status = if dispatched_log.decoded['dispatch_result']
                       Message.statuses[:dispatch_success]
                     else
                       Message.statuses[:dispatch_failed]
                     end
    # update proof
    message.proof = dispatched_log.evm_transaction.input[(-32 * 64)..].scan(/.{64}/).map { |item| "0x#{item}" }
    message.save!
  end
end

# accepted -> root_ready
def check_accepted_messages(networks)
  messages = Message.where(from_network: networks, to_network: networks, status: :accepted)
  messages.each do |message|
    next unless root_prepared?(message)

    message.update(status: :root_ready)
  end
end

# join query example:
# message_of_root = Message.joins("INNER JOIN pug_sub_api_aggregated_ormp_data ON messages.root = pug_sub_api_aggregated_ormp_data.ormp_data_root")
#   .where("pug_sub_api_aggregated_ormp_data.pug_network_id = ?", to_network.id)
#   .order("pug_sub_api_aggregated_ormp_data.timestamp DESC")
#   .first
def root_prepared?(message)
  latest_aggregated = Pug::EvmLog.with_network(message.to_network)
                                 .with_event('AggregatedOrmpData')
                                 .order(timestamp: :desc).first
  return false if latest_aggregated.nil?

  message_of_root = Message.find_by_root(latest_aggregated.ormp_data_root)
  return false if message_of_root.nil?

  block_number <= message_of_root.block_number
end

def sync_accepted_messages(network)
  latest_message_accepted_evm_logs(network).each do |evm_log|
    next if skip_message?(evm_log, network)

    ActiveRecord::Base.transaction do
      message = Message.create!(
        msg_hash: evm_log.decoded['msg_hash'],
        root: evm_log.decoded['root'],
        channel: evm_log.decoded['message_channel'],
        index: evm_log.decoded['message_index'],
        from_chain_id: evm_log.decoded['message_from_chain_id'],
        from: evm_log.decoded['message_from'],
        to_chain_id: evm_log.decoded['message_to_chain_id'],
        to: evm_log.decoded['message_to'],
        encoded: evm_log.decoded['message_encoded'],
        gas_limit: evm_log.decoded['message_gas_limit'],
        block_number: evm_log.block_number,
        block_timestamp: evm_log.timestamp,
        transaction_hash: evm_log.transaction_hash,
        status: :accepted,
        from_network: network,
        to_network: Pug::Network.find_by_chain_id(evm_log.decoded['message_to_chain_id'])
      )
      raise "message created failed: #{message.errors.full_messages}" if message.errors.any?
    end
  end
end

def skip_message?(message_accepted_log, network)
  # create message if not exists
  return true if Message.find_by(from_network: network, msg_hash: message_accepted_log.decoded['msg_hash'])

  false
end

def latest_message_accepted_evm_logs(network)
  last_message_index = Message.where(from_network: network).maximum(:index) || -1
  puts "  from `#{network.display_name}`s message index: #{last_message_index + 1}"

  Pug::EvmLog.with_network(network)
             .with_event('MessageAccepted')
             .where("(decoded->>'message_index')::int > ?", last_message_index)
end
