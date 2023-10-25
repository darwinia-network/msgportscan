class CreatePugSubApiSubApiFeedUpdateds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_sub_api_sub_api_feed_updateds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :beacon_id
      t.decimal :msg_root_count, precision: 78, scale: 0
      t.string :msg_root_root

      t.timestamps
    end
    add_index :pug_sub_api_sub_api_feed_updateds, :beacon_id
    add_index :pug_sub_api_sub_api_feed_updateds, :msg_root_count
    add_index :pug_sub_api_sub_api_feed_updateds, :msg_root_root
  end
end
