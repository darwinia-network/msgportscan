class CreatePugRelayerSetDstConfigs < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_relayer_set_dst_configs do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.decimal :p_chain_id, precision: 78, scale: 0
      t.decimal :p_base_gas, precision: 20, scale: 0
      t.decimal :p_gas_per_byte, precision: 20, scale: 0
    end
    add_index :pug_relayer_set_dst_configs, :p_chain_id
    add_index :pug_relayer_set_dst_configs, :p_base_gas
    add_index :pug_relayer_set_dst_configs, :p_gas_per_byte
  end
end
