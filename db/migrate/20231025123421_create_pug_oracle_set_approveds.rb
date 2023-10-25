class CreatePugOracleSetApproveds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_oracle_set_approveds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :operator
      t.boolean :approve

      t.timestamps
    end
    add_index :pug_oracle_set_approveds, :operator
    add_index :pug_oracle_set_approveds, :approve
  end
end
