class CreatePugSubApiRemoveBeacons < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_sub_api_remove_beacons do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.string :p_beacon_id
    end
    add_index :pug_sub_api_remove_beacons, :p_beacon_id
  end
end
