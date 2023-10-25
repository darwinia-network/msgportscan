class CreatePugRelayerAssigneds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_relayer_assigneds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.string :p_msg_hash
      t.decimal :p_fee, precision: 78, scale: 0
      t.string :p_params
      t.string :p_proof
    end
    add_index :pug_relayer_assigneds, :p_msg_hash
    add_index :pug_relayer_assigneds, :p_fee
    add_index :pug_relayer_assigneds, :p_params
    add_index :pug_relayer_assigneds, :p_proof
  end
end
