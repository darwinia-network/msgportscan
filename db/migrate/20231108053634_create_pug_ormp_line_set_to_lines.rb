class CreatePugOrmpLineSetToLines < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_ormp_line_set_to_lines do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.decimal :to_chain_id, precision: 78, scale: 0
      t.string :to_line
      t.datetime :timestamp
      t.integer :block_number
      t.integer :transaction_index
      t.integer :log_index

      t.timestamps
    end
    add_index :pug_ormp_line_set_to_lines, [:pug_network_id, :to_chain_id]
    add_index :pug_ormp_line_set_to_lines, [:pug_network_id, :to_line]
    add_index :pug_ormp_line_set_to_lines, %i[pug_network_id block_number transaction_index log_index], unique: true
  end
end
