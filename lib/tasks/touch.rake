desc 'touch messages'
task touch: :environment do
  $stdout.sync = true
  chain_ids = Rails.application.config.ormpscan2['chains']
  networks = Pug::Network.where(chain_id: chain_ids)

  loop do
    puts '= TOUCHING ==============================='
    Message.where(from_network: networks, to_network: networks)
           .order(block_timestamp: :desc)
           .limit(100)
           .each(&:touch)
    puts 'touched'

    puts "\n"
    sleep 60
  rescue StandardError => e
    puts e
    puts e.backtrace.join("\n")

    sleep 60
  end
end
