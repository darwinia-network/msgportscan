class AddExplorerToPugNetworks < ActiveRecord::Migration[7.1]
  def up
    add_column :pug_networks, :explorer, :string

    require 'open-uri'
    require 'json'

    networks = JSON.parse(URI.open('https://chainid.network/chains.json').read)
    networks.each do |network|
      n = Pug::Network.where(chain_id: network['chainId'])
      n.update(explorer: network['explorers'][0]['url']) if n && network['explorers'] && network['explorers'][0]
    end
  end

  def down
    remove_column :pug_networks, :explorer
  end
end
