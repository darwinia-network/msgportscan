namespace :messages do
  desc 'Start tracing messages'
  task trace: :environment do
    networks = Pug::Network.where(name: %w[crab arb_sep])

    loop do
      puts '= SYNCRONIZING ==============================='
      puts 'sync new accepted messages'
      networks.each do |network|
        sync_accepted_messages(network)
      end

      puts 'check accepted messages'
      check_accepted_messages

      puts 'check root ready messages'
      check_root_ready_messages

      puts 'check failed messages'
      check_failed_messages

      puts 'sleep 2 seconds'
      puts "\n"
      sleep 2
    rescue StandardError => e
      puts e
      puts e.backtrace.join("\n")

      sleep 2
    end
  end
end

# failed -> success/failed, cleared
def check_failed_messages
  messages = Message.where(status: :failed)
  messages.each do |message|
    # CHECK IF CLEARED
    clear_event = Pug::OrmpClearFailedMessage.find_by(msg_hash: message.msg_hash)
    next unless clear_event

    message.clear_transaction_hash = clear_event.evm_log.transaction_hash
    message.clear_block_number = clear_event.evm_log.block_number
    message.clear_block_timestamp = clear_event.evm_log.timestamp
    message.status = :cleared
    message.save!
    next

    # CHECK IF RETRIED, AND RECORD RETRIES
    # latest_retry_db = message.retries.last # find last retry of this message in database
    # block_timestamp = latest_retry_db.nil? ? message.block_timestamp : latest_retry_db.block_timestamp
    #
    # retries = MessageCheck.retry_events(message, block_timestamp)
    # next if retries.empty?
    #
    # retries.each do |retry_event|
    #   Retry.create!(
    #     message:,
    #     transaction_hash: retry_event['transactionHash'],
    #     block_number: retry_event['blockNumber'],
    #     block_timestamp: retry_event['blockTimestamp'],
    #     dispatch_result: retry_event['dispatchResult']
    #   )
    # end
    #
    # # UPDATE MESSAGE STATUS
    # last_retry = retries.last
    # message.update! status: if last_retry['dispatchResult']
    #                           Message.statuses[:dispatch_success]
    #                         else
    #                           Message.statuses[:dispatch_failed]
    #                         end
  end
end

# root_ready -> success/failed
def check_root_ready_messages
  messages = Message.where(status: :root_ready)
  messages.each do |message|
    dispatch_event = Pug::OrmpMessageDispatched.find_by(msg_hash: message.msg_hash)
    next if dispatch_event.nil?

    message.dispatch_transaction_hash = dispatch_event.evm_log.transaction_hash
    message.dispatch_block_number = dispatch_event.evm_log.block_number
    message.dispatch_block_timestamp = dispatch_event.evm_log.timestamp
    message.status = if dispatch_event.dispatch_result
                       Message.statuses[:dispatch_success]
                     else
                       Message.statuses[:dispatch_failed]
                     end
    message.save!
  end
end

# accepted -> root_ready
def check_accepted_messages
  messages = Message.where(status: :accepted)
  messages.each do |message|
    next unless root_prepared?(message)

    message.update(status: :root_ready)
  end
end

def root_prepared?(message)
  latest_aggregated_event = Pug::SubApiAggregatedOrmpDatum.where(pug_network: message.to_network).order(created_at: :desc).first
  return false if latest_aggregated_event.nil?

  message.block_number <= latest_aggregated_event.evm_log.block_number
end

def sync_accepted_messages(network)
  latest_message_accepted_events(network).each do |event|
    next if skip_message?(event, network)

    ActiveRecord::Base.transaction do
      message = Message.create!(
        msg_hash: event.msg_hash,
        root: event.root,
        channel: event.message_channel,
        index: event.message_index,
        from_chain_id: event.message_from_chain_id,
        from: event.message_from,
        to_chain_id: event.message_to_chain_id,
        to: event.message_to,
        encoded: event.message_encoded,
        block_number: event.evm_log.block_number,
        block_timestamp: event.evm_log.timestamp,
        transaction_hash: event.evm_log.transaction_hash,
        status: :accepted,
        from_network: network,
        to_network: Pug::Network.find_by_chain_id(event.message_to_chain_id)
      )
      raise "message created failed: #{message.errors.full_messages}" if message.errors.any?
    end
  end
end

def skip_message?(message_accepted_event, network)
  # create message if not exists
  return true if Message.find_by(from_network: network, msg_hash: message_accepted_event.msg_hash)

  false
end

def latest_message_accepted_events(network)
  last_message_index = Message.where(from_network: network).maximum(:index) || -1
  puts "  from `#{network.display_name}`s message index: #{last_message_index + 1}"

  Pug::OrmpMessageAccepted.where(pug_network: network).where('message_index > ?', last_message_index)
end
