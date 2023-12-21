class CreatePugSubApiAggregatedOrmpData < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_sub_api_aggregated_ormp_data do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.decimal :chain_id, precision: 78, scale: 0
      t.decimal :ormp_data_count, precision: 78, scale: 0
      t.string :ormp_data_root
      t.datetime :timestamp
      t.integer :block_number
      t.integer :transaction_index
      t.integer :log_index

      t.timestamps
    end
    add_index :pug_sub_api_aggregated_ormp_data, [:pug_network_id, :chain_id]
    add_index :pug_sub_api_aggregated_ormp_data, [:pug_network_id, :ormp_data_count]
    add_index :pug_sub_api_aggregated_ormp_data, [:pug_network_id, :ormp_data_root]
    add_index :pug_sub_api_aggregated_ormp_data, %i[pug_network_id block_number transaction_index log_index], unique: true
  end
end
