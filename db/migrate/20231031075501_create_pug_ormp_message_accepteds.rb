class CreatePugOrmpMessageAccepteds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_ormp_message_accepteds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :msg_hash
      t.string :root
      t.string :message_channel
      t.decimal :message_index, precision: 78, scale: 0
      t.decimal :message_from_chain_id, precision: 78, scale: 0
      t.string :message_from
      t.decimal :message_to_chain_id, precision: 78, scale: 0
      t.string :message_to
      t.string :message_encoded
      t.datetime :timestamp
      t.integer :block_number
      t.integer :transaction_index
      t.integer :log_index

      t.timestamps
    end
    add_index :pug_ormp_message_accepteds, [:pug_network_id, :msg_hash]
    add_index :pug_ormp_message_accepteds, [:pug_network_id, :root]
    add_index :pug_ormp_message_accepteds, [:pug_network_id, :message_channel]
    add_index :pug_ormp_message_accepteds, [:pug_network_id, :message_index]
    add_index :pug_ormp_message_accepteds, [:pug_network_id, :message_from_chain_id]
    add_index :pug_ormp_message_accepteds, [:pug_network_id, :message_from]
    add_index :pug_ormp_message_accepteds, [:pug_network_id, :message_to_chain_id]
    add_index :pug_ormp_message_accepteds, [:pug_network_id, :message_to]
    add_index :pug_ormp_message_accepteds, [:pug_network_id, :message_encoded]
    add_index :pug_ormp_message_accepteds, %i[pug_network_id block_number transaction_index log_index], unique: true
  end
end
