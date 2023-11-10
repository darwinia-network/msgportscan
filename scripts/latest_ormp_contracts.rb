require 'open-uri'
require 'json'

chain_ids = [42_161, 46]
chain_ids.each do |chain_id|
  latest = JSON.parse URI.open("https://raw.githubusercontent.com/darwinia-network/ORMP/main/script/output/#{chain_id}/deploy.a-latest.json").read
  puts "== Chain ID: #{chain_id} =="
  puts "   ORMP: #{latest['ORMP']}"
  puts " ORACLE: #{latest['ORACLE']}"
  puts "RELAYER: #{latest['RELAYER']}"

  lastest_subapi = JSON.parse URI.open("https://raw.githubusercontent.com/subapidao/subapi/main/script/output/#{chain_id}/deploy.a-latest.json").read
  puts " SUBAPI: #{lastest_subapi['SUBAPI']}"
  puts "\n"
end
