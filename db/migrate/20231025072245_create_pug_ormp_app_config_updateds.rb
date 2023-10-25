class CreatePugOrmpAppConfigUpdateds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_ormp_app_config_updateds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.string :p_ua
      t.string :p_oracle
      t.string :p_relayer
    end
    add_index :pug_ormp_app_config_updateds, :p_ua
    add_index :pug_ormp_app_config_updateds, :p_oracle
    add_index :pug_ormp_app_config_updateds, :p_relayer
  end
end
