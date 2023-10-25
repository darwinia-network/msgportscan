class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.integer :index
      t.string :msg_hash
      t.string :root
      t.string :channel
      t.integer :from_chain_id
      t.string :from
      t.integer :to_chain_id
      t.string :to
      t.integer :block_number
      t.integer :block_timestamp
      t.string :transaction_hash
      t.integer :status
      t.string :encoded
      t.integer :from_network_id
      t.integer :to_network_id
      t.string :dispatch_transaction_hash
      t.integer :dispatch_block_number
      t.integer :dispatch_block_timestamp
      t.string :clear_transaction_hash
      t.integer :clear_block_number
      t.integer :clear_block_timestamp
    end
    add_index :messages, :msg_hash, unique: true
    add_index :messages, :root, unique: true
  end
end
