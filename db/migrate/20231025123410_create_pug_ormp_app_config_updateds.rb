class CreatePugOrmpAppConfigUpdateds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_ormp_app_config_updateds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :ua
      t.string :oracle
      t.string :relayer

      t.timestamps
    end
    add_index :pug_ormp_app_config_updateds, :ua
    add_index :pug_ormp_app_config_updateds, :oracle
    add_index :pug_ormp_app_config_updateds, :relayer
  end
end
