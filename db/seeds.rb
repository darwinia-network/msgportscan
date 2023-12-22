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

# https://chainid.network/chains.json
puts '-- Import Pug::Network records'

chain_id = 1
name = 'eth'
display_name = 'Ethereum Mainnet'
rpc = 'https://ethereum.publicnode.com'
explorer = 'https://etherscan.io'
Pug::Network.create(chain_id:, name:, display_name:, rpc:, explorer:, scan_span: 2000)

chain_id = 42_161
name = 'arb1'
display_name = 'Arbitrum One'
rpc = 'https://arbitrum-one.publicnode.com'
explorer = 'https://arbiscan.io'
Pug::Network.create(chain_id:, name:, display_name:, rpc:, explorer:, scan_span: 2000)

chain_id = 46
name = 'darwinia'
display_name = 'Darwinia Network'
rpc = 'https://rpc.darwinia.network'
explorer = 'https://darwinia.subscan.io'
Pug::Network.create(chain_id:, name:, display_name:, rpc:, explorer:, scan_span: 2000)

chain_id = 44
name = 'crab'
display_name = 'Crab Network'
rpc = 'https://crab-rpc.darwinia.network'
explorer = 'https://crab.subscan.io'
Pug::Network.create(chain_id:, name:, display_name:, rpc:, explorer:, scan_span: 2000)

# chain_id = 2_494_104_990
# name = 'tron_shasta'
# display_name = 'Tron Shasta'
# rpc = 'https://api.shasta.trongrid.io/jsonrpc'
# explorer = 'https://shasta.tronscan.org'
# Pug::Network.create(chain_id:, name:, display_name:, rpc:, explorer:, scan_span: 2000)

# chain_id = 728_126_428
# name = 'tron'
# display_name = 'Tron'
# rpc = 'https://api.trongrid.io/jsonrpc'
# explorer = 'https://tronscan.io'
# Pug::Network.create(chain_id:, name:, display_name:, rpc:, explorer:, scan_span: 2000)

puts "Imported #{Pug::Network.count} networks."
