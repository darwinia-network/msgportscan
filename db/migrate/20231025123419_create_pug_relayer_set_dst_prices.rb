class CreatePugRelayerSetDstPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_relayer_set_dst_prices do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.decimal :chain_id, precision: 78, scale: 0
      t.decimal :dst_price_ratio, precision: 39, scale: 0
      t.decimal :dst_gas_price_in_wei, precision: 39, scale: 0

      t.timestamps
    end
    add_index :pug_relayer_set_dst_prices, :chain_id
    add_index :pug_relayer_set_dst_prices, :dst_price_ratio
    add_index :pug_relayer_set_dst_prices, :dst_gas_price_in_wei
  end
end
