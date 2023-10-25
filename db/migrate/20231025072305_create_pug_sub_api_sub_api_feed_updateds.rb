class CreatePugSubApiSubApiFeedUpdateds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_sub_api_sub_api_feed_updateds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.string :p_beacon_id
      t.decimal :p_msg_root_count, precision: 78, scale: 0
      t.string :p_msg_root_root
    end
    add_index :pug_sub_api_sub_api_feed_updateds, :p_beacon_id
    add_index :pug_sub_api_sub_api_feed_updateds, :p_msg_root_count
    add_index :pug_sub_api_sub_api_feed_updateds, :p_msg_root_root
  end
end
