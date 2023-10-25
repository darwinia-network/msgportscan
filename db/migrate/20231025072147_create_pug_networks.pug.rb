# This migration comes from pug (originally 20231018054931)
class CreatePugNetworks < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_networks do |t|
      t.bigint :chain_id
      t.string :name
      t.string :display_name
      t.json :rpc_list
      t.integer :scan_span, default: 5000
      t.integer :last_scanned_block, default: 0

      t.timestamps
    end
  end
end