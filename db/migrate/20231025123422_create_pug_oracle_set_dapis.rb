class CreatePugOracleSetDapis < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_oracle_set_dapis do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.decimal :chain_id, precision: 78, scale: 0
      t.string :dapi

      t.timestamps
    end
    add_index :pug_oracle_set_dapis, :chain_id
    add_index :pug_oracle_set_dapis, :dapi
  end
end
