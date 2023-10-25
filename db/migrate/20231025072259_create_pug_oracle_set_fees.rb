class CreatePugOracleSetFees < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_oracle_set_fees do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.decimal :p_chain_id, precision: 78, scale: 0
      t.decimal :p_fee, precision: 78, scale: 0
    end
    add_index :pug_oracle_set_fees, :p_chain_id
    add_index :pug_oracle_set_fees, :p_fee
  end
end
