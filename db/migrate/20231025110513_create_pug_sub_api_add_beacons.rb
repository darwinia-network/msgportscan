class CreatePugSubApiAddBeacons < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_sub_api_add_beacons do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :e_beacon_id
      t.string :e_beacon_airnode
      t.string :e_beacon_endpoint_id
      t.string :e_beacon_sponsor
      t.string :e_beacon_sponsor_wallet

      t.timestamps
    end
    add_index :pug_sub_api_add_beacons, :e_beacon_id
    add_index :pug_sub_api_add_beacons, :e_beacon_airnode
    add_index :pug_sub_api_add_beacons, :e_beacon_endpoint_id
    add_index :pug_sub_api_add_beacons, :e_beacon_sponsor
    add_index :pug_sub_api_add_beacons, :e_beacon_sponsor_wallet
  end
end
