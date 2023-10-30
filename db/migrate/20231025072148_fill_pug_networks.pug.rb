# This migration comes from pug (originally 20231018055158)
class FillPugNetworks < ActiveRecord::Migration[7.1]
  def up
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
        scan_span: 5000
      )
    end
  end

  def down
    Pug::Network.delete_all
  end
end
