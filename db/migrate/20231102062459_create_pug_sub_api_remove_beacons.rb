class CreatePugSubApiRemoveBeacons < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_sub_api_remove_beacons do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :beacon_id
      t.datetime :timestamp
      t.integer :block_number
      t.integer :transaction_index
      t.integer :log_index

      t.timestamps
    end
    add_index :pug_sub_api_remove_beacons, [:pug_network_id, :beacon_id]
    add_index :pug_sub_api_remove_beacons, %i[pug_network_id block_number transaction_index log_index], unique: true
  end
end
