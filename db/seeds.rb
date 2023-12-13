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

chain_id = 421614
name = 'arb_sep'
display_name = 'Arbitrum Sepolia'
rpc = "https://sepolia-rollup.arbitrum.io/rpc"
explorer =  "https://sepolia.arbiscan.io"
Pug::Network.create(chain_id: , name: , display_name: , rpc: , explorer: , scan_span: 2000)
puts "`Arbitrum Sepolia` created."

chain_id = 44
name = 'crab'
display_name = 'Crab Network'
rpc = "https://darwiniacrab-rpc.dwellir.com"
explorer =  "https://crab.subscan.io"
Pug::Network.create(chain_id: , name: , display_name: , rpc: , explorer: , scan_span: 2000)
puts "`Crab Network` created."

chain_id = 11155111
name = 'sep'
display_name = 'Sepolia'
rpc = "https://ethereum-sepolia.publicnode.com"
explorer =  "https://sepolia.etherscan.io"
Pug::Network.create(chain_id: , name: , display_name: , rpc: , explorer: , scan_span: 2000)
puts "`Sepolia` created."

# chain_id = 2494104990
# name = 'tron_shasta'
# display_name = 'Tron Shasta'
# rpc = "https://api.shasta.trongrid.io/jsonrpc"
# explorer =  "https://shasta.tronscan.org"
# Pug::Network.create(chain_id: , name: , display_name: , rpc: , explorer: , scan_span: 2000)

chain_id = 728126428
name = 'tron'
display_name = 'Tron'
rpc = "https://api.trongrid.io/jsonrpc"
explorer =  "https://tronscan.io"
Pug::Network.create(chain_id: , name: , display_name: , rpc: , explorer: , scan_span: 2000)
puts "`Tron` created."

puts "Imported #{Pug::Network.count} networks."


