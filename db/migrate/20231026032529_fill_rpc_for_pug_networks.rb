class FillRpcForPugNetworks < ActiveRecord::Migration[7.1]
  def up
    require 'open-uri'
    require 'json'

    networks = JSON.parse(URI.open('https://chainid.network/chains_mini.json').read)
    networks.each do |network|
      n = Pug::Network.where(chain_id: network['chainId'])
      n.update rpc: network['rpc'][0] if n && network['rpc'] && network['rpc'][0]
    end
  end

  def down
    Pug::Network.update_all(rpc: nil)
  end
end
