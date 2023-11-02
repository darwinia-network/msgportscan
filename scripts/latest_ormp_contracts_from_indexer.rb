require 'open-uri'
require 'yaml'

chain_names = %w[arbitrum-sepolia crab]
chain_names.each do |chain_name|
  r = YAML.load URI.open("https://raw.githubusercontent.com/darwinia-network/indexer/main/thegraph/ormpipe/subgraph-#{chain_name}.yaml").read
  puts "== Chain Name: #{chain_name} =="
  r['dataSources'].each do |data_source|
    puts "#{data_source['name']}: #{data_source['source']['address']}"
  end
  puts "\n"
end
