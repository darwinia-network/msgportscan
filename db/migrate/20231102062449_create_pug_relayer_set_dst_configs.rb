class CreatePugRelayerSetDstConfigs < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_relayer_set_dst_configs do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.decimal :chain_id, precision: 78, scale: 0
      t.decimal :base_gas, precision: 20, scale: 0
      t.decimal :gas_per_byte, precision: 20, scale: 0
      t.datetime :timestamp
      t.integer :block_number
      t.integer :transaction_index
      t.integer :log_index

      t.timestamps
    end
    add_index :pug_relayer_set_dst_configs, [:pug_network_id, :chain_id]
    add_index :pug_relayer_set_dst_configs, [:pug_network_id, :base_gas]
    add_index :pug_relayer_set_dst_configs, [:pug_network_id, :gas_per_byte]
    add_index :pug_relayer_set_dst_configs, %i[pug_network_id block_number transaction_index log_index], unique: true
  end
end
