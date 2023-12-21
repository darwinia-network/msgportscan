class CreatePugSubApiOwnershipTransferStarteds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_sub_api_ownership_transfer_starteds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :previous_owner
      t.string :new_owner
      t.datetime :timestamp
      t.integer :block_number
      t.integer :transaction_index
      t.integer :log_index

      t.timestamps
    end
    add_index :pug_sub_api_ownership_transfer_starteds, [:pug_network_id, :previous_owner]
    add_index :pug_sub_api_ownership_transfer_starteds, [:pug_network_id, :new_owner]
    add_index :pug_sub_api_ownership_transfer_starteds, %i[pug_network_id block_number transaction_index log_index], unique: true
  end
end
