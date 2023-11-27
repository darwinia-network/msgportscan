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
