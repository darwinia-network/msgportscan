class CreatePugRelayerAssigneds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_relayer_assigneds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :msg_hash
      t.decimal :fee, precision: 78, scale: 0
      t.string :params
      t.string :proof

      t.timestamps
    end
    add_index :pug_relayer_assigneds, :msg_hash
    add_index :pug_relayer_assigneds, :fee
    add_index :pug_relayer_assigneds, :params
    add_index :pug_relayer_assigneds, :proof
  end
end
