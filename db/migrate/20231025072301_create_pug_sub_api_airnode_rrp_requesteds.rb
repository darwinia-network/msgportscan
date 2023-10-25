class CreatePugSubApiAirnodeRrpRequesteds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_sub_api_airnode_rrp_requesteds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.string :p_beacon_id
      t.string :p_request_id
    end
    add_index :pug_sub_api_airnode_rrp_requesteds, :p_beacon_id
    add_index :pug_sub_api_airnode_rrp_requesteds, :p_request_id
  end
end
