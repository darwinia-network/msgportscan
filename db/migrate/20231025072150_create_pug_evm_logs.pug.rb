# This migration comes from pug (originally 20231019000315)
class CreatePugEvmLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_evm_logs do |t|
      t.integer :network_id
      t.integer :evm_contract_id
      t.string :address
      t.text :data
      t.string :block_hash
      t.integer :block_number
      t.string :transaction_hash
      t.integer :transaction_index
      t.integer :log_index
      t.datetime :timestamp
      t.string :topic0
      t.string :topic1
      t.string :topic2
      t.string :topic3
      # decoded
      t.string :event_name
      t.jsonb :decoded

      t.timestamps
    end

    add_index :pug_evm_logs, %i[network_id block_number transaction_index log_index], unique: true
    add_index :pug_evm_logs, :topic0
    add_index :pug_evm_logs, :topic1
    add_index :pug_evm_logs, :topic2
    add_index :pug_evm_logs, :topic3

    # For decoded data query
    add_index :pug_evm_logs, :network_id
    add_index :pug_evm_logs, :event_name
    add_index :pug_evm_logs, :decoded, using: :gin # http://www.pgsql.tech/article_104_10000050
  end
end
