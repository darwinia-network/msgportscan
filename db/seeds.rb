# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts '== Start seeding'

puts '-- Import Pug::Network records'
require 'open-uri'
require 'json'

networks = JSON.parse(URI.open('https://chainid.network/chains.json').read)
networks.each do |network|
  rpc_url = network['rpc']&.select { |url| url.start_with?('http') && url !~ /\$\{(.+)\}/ }&.first
  explorer_url = network['explorers']&.first&.[]('url')
  Pug::Network.create(
    chain_id: network['chainId'],
    name: network['shortName'].underscore,
    display_name: network['name'],
    rpc: rpc_url,
    explorer: explorer_url,
    scan_span: 2000
  )
end
puts "Imported #{Pug::Network.count} networks."

def add_contract(network, contract_address, api_key = nil)
  puts "api_key: #{api_key}"
  if api_key.present?
    puts `ETHERSCAN_API_KEY=#{api_key} rails 'pug:add_contract[#{network.chain_id},#{contract_address}]'`
  else
    puts `rails 'pug:add_contract[#{network.chain_id},#{contract_address}]'`
  end
  sleep(2)
end

puts '-- Add Pug::EvmContract records'
chain_ids = Rails.application.config.ormpscan2['chains']
chain_ids.each_with_index do |chain_id, i|
  puts "#{i}. Chain ID: #{chain_id}"

  latest = JSON.parse URI.open("https://raw.githubusercontent.com/darwinia-network/ORMP/main/script/output/#{chain_id}/deploy.a-latest.json").read
  lastest_subapi = JSON.parse URI.open("https://raw.githubusercontent.com/subapidao/subapi/main/script/output/#{chain_id}/deploy.a-latest.json").read
  lastest_ormp_line = JSON.parse URI.open("https://raw.githubusercontent.com/darwinia-network/darwinia-msgport/main/script/output/#{chain_id}/deploy_ormp_line.a-latest.json").read

  network = Pug::Network.find_by(chain_id:)

  require 'dotenv'
  Dotenv.load
  api_key = ENV["EXPLORER_#{network.name.underscore.upcase}_API_KEY"]

  add_contract(network, latest['ORMP'], api_key)
  add_contract(network, latest['ORACLE'], api_key)
  add_contract(network, latest['RELAYER'], api_key)
  add_contract(network, lastest_subapi['SUBAPI'], api_key)
  add_contract(network, lastest_ormp_line['ORMP_LINE'], api_key)
end
