require 'open-uri'
require 'json'
require 'dotenv'
Dotenv.load

namespace :contracts do
  desc 'Add ormp contracts of all configurated networks'
  task add_all_ormp_contracts: :environment do
    puts '-- Update Pug::EvmContract records'
    chain_ids = Rails.application.config.ormpscan2['chains']

    chain_ids.each do |chain_id|
      add_ormp_contracts(chain_id)
    end
  end

  desc 'Add ormp contracts of a network'
  task :add_ormp_contracts, [:chain_id] => :environment do |_, args|
    chain_id = args[:chain_id].to_i
    add_ormp_contracts(chain_id)
  end
end

def add_ormp_contracts(chain_id)
  network = Pug::Network.find_by(chain_id:)
  puts "== Chain: #{network.display_name}(#{chain_id}) ==="

  latest = JSON.parse URI.open("https://raw.githubusercontent.com/darwinia-network/ORMP/main/script/output/#{chain_id}/deploy.a-latest.json").read
  puts 'ORMP'
  add_contract(network, latest['ORMP'])
  puts 'ORACLE'
  add_contract(network, latest['ORACLE'])
  puts 'RELAYER'
  add_contract(network, latest['RELAYER'])

  puts 'SUBAPI'
  lastest_subapi = JSON.parse URI.open("https://raw.githubusercontent.com/subapidao/subapi/main/script/output/#{chain_id}/deploy.a-latest.json").read
  add_contract(network, lastest_subapi['SUBAPI'])

  puts 'ORMP LINE'
  lastest_ormp_line = JSON.parse URI.open("https://raw.githubusercontent.com/darwinia-network/darwinia-msgport/main/script/output/#{chain_id}/deploy_ormp_line.a-latest.json").read
  add_contract(network, lastest_ormp_line['ORMP_LINE'])

  begin
    puts 'ORMP LINE EXT'
    lastest_ormp_line_ext = JSON.parse(URI.open("https://raw.githubusercontent.com/darwinia-network/darwinia-msgport/main/script/output/#{chain_id}/deploy_ormp_line_ext.a-latest.json").read)
    add_contract(network, lastest_ormp_line_ext['ORMP_LINE_EXT'])
  rescue StandardError => e
    puts e.message
  end
end

def add_contract(network, contract_address)
  explorer_api_key_name = "EXPLORER_#{network.name.underscore.upcase}_API_KEY"
  api_key = ENV[explorer_api_key_name]
  puts "#{explorer_api_key_name}: #{api_key.nil? ? 'nil' : 'present'}"
  if api_key.present?
    puts `ETHERSCAN_API_KEY=#{api_key} rails 'pug:add_contract[#{network.chain_id},#{contract_address}]'`
  else
    puts `rails 'pug:add_contract[#{network.chain_id},#{contract_address}]'`
  end
  puts "\n"
  sleep(10)
end
