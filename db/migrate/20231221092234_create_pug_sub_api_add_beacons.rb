class CreatePugSubApiAddBeacons < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_sub_api_add_beacons do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.decimal :chain_id, precision: 78, scale: 0
      t.string :beacon_id
      t.decimal :beacon_chain_id, precision: 78, scale: 0
      t.string :beacon_airnode
      t.string :beacon_endpoint_id
      t.string :beacon_sponsor
      t.string :beacon_sponsor_wallet
      t.datetime :timestamp
      t.integer :block_number
      t.integer :transaction_index
      t.integer :log_index

      t.timestamps
    end
    add_index :pug_sub_api_add_beacons, [:pug_network_id, :chain_id]
    add_index :pug_sub_api_add_beacons, [:pug_network_id, :beacon_id]
    add_index :pug_sub_api_add_beacons, [:pug_network_id, :beacon_chain_id]
    add_index :pug_sub_api_add_beacons, [:pug_network_id, :beacon_airnode]
    add_index :pug_sub_api_add_beacons, [:pug_network_id, :beacon_endpoint_id]
    add_index :pug_sub_api_add_beacons, [:pug_network_id, :beacon_sponsor]
    add_index :pug_sub_api_add_beacons, [:pug_network_id, :beacon_sponsor_wallet]
    add_index :pug_sub_api_add_beacons, %i[pug_network_id block_number transaction_index log_index], unique: true
  end
end
