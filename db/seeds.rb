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

puts '=== Import Pug::Network records ==='
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
puts 'Imported.'

puts '=== Add Pug::EvmContract records ==='
chain_ids = [421_614, 44]
chain_ids.each do |chain_id|
  puts "= Chain ID: #{chain_id}"
  puts `rails 'pug:add_contract[#{chain_id},0x009D223Aad560e72282db9c0438Ef1ef2bf7703D]'`
  puts `rails 'pug:add_contract[#{chain_id},0x00BD655DDfA7aFeF4BB109FE1F938724527B49D8]'`
  puts `rails 'pug:add_contract[#{chain_id},0x003605167cd4C36063a7B63e604497e623Bb8B10]'`
  puts `rails 'pug:add_contract[#{chain_id},0x00d917EC19A6b8837ADFcF8adE3D6faF62e0F587]'`
end

puts 'Added.'
