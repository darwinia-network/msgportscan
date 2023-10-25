class CreatePugOracleSetApproveds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_oracle_set_approveds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.string :p_operator
      t.boolean :p_approve
    end
    add_index :pug_oracle_set_approveds, :p_operator
    add_index :pug_oracle_set_approveds, :p_approve
  end
end
