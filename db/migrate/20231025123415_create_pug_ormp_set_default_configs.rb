class CreatePugOrmpSetDefaultConfigs < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_ormp_set_default_configs do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :oracle
      t.string :relayer

      t.timestamps
    end
    add_index :pug_ormp_set_default_configs, :oracle
    add_index :pug_ormp_set_default_configs, :relayer
  end
end
