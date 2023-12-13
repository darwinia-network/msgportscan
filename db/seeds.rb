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

chain_id = 2_494_104_990
name = 'tron_shasta'
display_name = 'Tron Shasta'
rpc = 'https://api.shasta.trongrid.io/jsonrpc'
explorer = 'https://shasta.tronscan.org'
Pug::Network.create(chain_id:, name:, display_name:, rpc:, explorer:, scan_span: 2000)

chain_id = 728_126_428
name = 'tron'
display_name = 'Tron'
rpc = 'https://api.trongrid.io/jsonrpc'
explorer = 'https://tronscan.io'
Pug::Network.create(chain_id:, name:, display_name:, rpc:, explorer:, scan_span: 2000)

puts "Imported #{Pug::Network.count} networks."
