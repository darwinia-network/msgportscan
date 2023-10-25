class CreatePugRelayerAssigneds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_relayer_assigneds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :e_msg_hash
      t.decimal :e_fee, precision: 78, scale: 0
      t.string :e_params
      t.string :e_proof

      t.timestamps
    end
    add_index :pug_relayer_assigneds, :e_msg_hash
    add_index :pug_relayer_assigneds, :e_fee
    add_index :pug_relayer_assigneds, :e_params
    add_index :pug_relayer_assigneds, :e_proof
  end
end
