class CreatePugSubApiRemoveBeacons < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_sub_api_remove_beacons do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :beacon_id

      t.timestamps
    end
    add_index :pug_sub_api_remove_beacons, :beacon_id
  end
end
