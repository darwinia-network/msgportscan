class CreatePugOrmpMessageDispatcheds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_ormp_message_dispatcheds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :msg_hash
      t.boolean :dispatch_result

      t.timestamps
    end
    add_index :pug_ormp_message_dispatcheds, :msg_hash
    add_index :pug_ormp_message_dispatcheds, :dispatch_result
  end
end
