require 'open-uri'
require 'json'
require 'dotenv'
Dotenv.load

namespace :contracts do
  desc 'Update contracts of configurated networks'
  task add: :environment do
    puts '-- Update Pug::EvmContract records'
    chain_ids = Rails.application.config.ormpscan2['chains']
    chain_ids.each_with_index do |chain_id, i|
      puts "#{i}. Chain ID: #{chain_id}"

      latest = JSON.parse URI.open("https://raw.githubusercontent.com/darwinia-network/ORMP/main/script/output/#{chain_id}/deploy.a-latest.json").read
      lastest_ormp_port = JSON.parse URI.open("https://raw.githubusercontent.com/darwinia-network/darwinia-msgport/main/script/output/#{chain_id}/deploy_ormp_port.a-latest.json").read

      network = Pug::Network.find_by(chain_id:)

      add_contract(network, latest['ORMP'])
      add_contract(network, latest['ORACLE'])
      add_contract(network, latest['RELAYER'])
      add_contract(network, lastest_ormp_port['ORMP_PORT'])
    end
  end
end

def add_contract(network, contract_address)
  api_key = ENV["EXPLORER_#{network.name.underscore.upcase}_API_KEY"]
  puts "API_KEY: #{api_key.nil? ? 'nil' : 'present'}"
  if api_key.present?
    puts `ETHERSCAN_API_KEY=#{api_key} rails 'pug:add_contract[#{network.chain_id},#{contract_address}]' --trace`
  else
    puts `rails 'pug:add_contract[#{network.chain_id},#{contract_address}]' --trace`
  end
  sleep(10)
end
