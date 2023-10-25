class CreatePugOrmpSetDefaultConfigs < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_ormp_set_default_configs do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.string :p_oracle
      t.string :p_relayer
    end
    add_index :pug_ormp_set_default_configs, :p_oracle
    add_index :pug_ormp_set_default_configs, :p_relayer
  end
end
