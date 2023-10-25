class CreatePugSubApiAggregatedOrmpData < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_sub_api_aggregated_ormp_data do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.decimal :p_ormp_data_count, precision: 78, scale: 0
      t.string :p_ormp_data_root
    end
    add_index :pug_sub_api_aggregated_ormp_data, :p_ormp_data_count
    add_index :pug_sub_api_aggregated_ormp_data, :p_ormp_data_root
  end
end
