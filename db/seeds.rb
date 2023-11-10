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

puts '-- Add Pug::EvmContract records'
chain_ids = Rails.application.config.ormpscan2['chains']
chain_ids.each_with_index do |chain_id, i|
  latest = JSON.parse URI.open("https://raw.githubusercontent.com/darwinia-network/ORMP/main/script/output/#{chain_id}/deploy.a-latest.json").read
  lastest_subapi = JSON.parse URI.open("https://raw.githubusercontent.com/subapidao/subapi/main/script/output/#{chain_id}/deploy.a-latest.json").read
  lastest_ormp_line = JSON.parse URI.open("https://raw.githubusercontent.com/darwinia-network/darwinia-msgport/main/script/output/#{chain_id}/deploy_ormp_line.a-latest.json").read
  puts "#{i}. Chain ID: #{chain_id}"
  puts `rails 'pug:add_contract[#{chain_id},#{latest['ORMP']}]'`
  puts `rails 'pug:add_contract[#{chain_id},#{latest['ORACLE']}]'`
  puts `rails 'pug:add_contract[#{chain_id},#{latest['RELAYER']}]'`
  puts `rails 'pug:add_contract[#{chain_id},#{lastest_subapi['SUBAPI']}]'`
  puts `rails 'pug:add_contract[#{chain_id},#{lastest_ormp_line['ORMP_LINE']}]'`
end
