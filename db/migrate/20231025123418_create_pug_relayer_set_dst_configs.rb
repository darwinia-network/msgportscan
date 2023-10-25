class CreatePugRelayerSetDstConfigs < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_relayer_set_dst_configs do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.decimal :chain_id, precision: 78, scale: 0
      t.decimal :base_gas, precision: 20, scale: 0
      t.decimal :gas_per_byte, precision: 20, scale: 0

      t.timestamps
    end
    add_index :pug_relayer_set_dst_configs, :chain_id
    add_index :pug_relayer_set_dst_configs, :base_gas
    add_index :pug_relayer_set_dst_configs, :gas_per_byte
  end
end
