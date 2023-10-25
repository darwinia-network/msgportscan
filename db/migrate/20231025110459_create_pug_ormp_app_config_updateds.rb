class CreatePugOrmpAppConfigUpdateds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_ormp_app_config_updateds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :e_ua
      t.string :e_oracle
      t.string :e_relayer

      t.timestamps
    end
    add_index :pug_ormp_app_config_updateds, :e_ua
    add_index :pug_ormp_app_config_updateds, :e_oracle
    add_index :pug_ormp_app_config_updateds, :e_relayer
  end
end
