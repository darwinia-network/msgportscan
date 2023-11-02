require 'open-uri'
require 'json'

chain_ids = [421_614, 44]
chain_ids.each do |chain_id|
  latest = JSON.parse URI.open("https://raw.githubusercontent.com/darwinia-network/ORMP/main/script/output/#{chain_id}/deploy.a-latest.json").read
  puts "== Chain ID: #{chain_id} =="
  puts "   ORMP: #{latest['ORMP']}"
  puts " ORACLE: #{latest['ORACLE']}"
  puts "RELAYER: #{latest['RELAYER']}"
  puts "\n"
end
