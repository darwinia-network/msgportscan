class CreatePugOracleAssigneds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_oracle_assigneds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.string :p_msg_hash
      t.decimal :p_fee, precision: 78, scale: 0
    end
    add_index :pug_oracle_assigneds, :p_msg_hash
    add_index :pug_oracle_assigneds, :p_fee
  end
end
