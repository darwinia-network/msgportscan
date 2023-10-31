class CreatePugOrmpMessageDispatcheds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_ormp_message_dispatcheds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :msg_hash
      t.boolean :dispatch_result
      t.datetime :timestamp
      t.integer :block_number
      t.integer :transaction_index
      t.integer :log_index

      t.timestamps
    end
    add_index :pug_ormp_message_dispatcheds, [:pug_network_id, :msg_hash]
    add_index :pug_ormp_message_dispatcheds, [:pug_network_id, :dispatch_result]
    add_index :pug_ormp_message_dispatcheds, %i[pug_network_id block_number transaction_index log_index], unique: true
  end
end
