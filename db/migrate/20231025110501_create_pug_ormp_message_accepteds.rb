class CreatePugOrmpMessageAccepteds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_ormp_message_accepteds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :e_msg_hash
      t.string :e_root
      t.string :e_message_channel
      t.decimal :e_message_index, precision: 78, scale: 0
      t.decimal :e_message_from_chain_id, precision: 78, scale: 0
      t.string :e_message_from
      t.decimal :e_message_to_chain_id, precision: 78, scale: 0
      t.string :e_message_to
      t.string :e_message_encoded

      t.timestamps
    end
    add_index :pug_ormp_message_accepteds, :e_msg_hash
    add_index :pug_ormp_message_accepteds, :e_root
    add_index :pug_ormp_message_accepteds, :e_message_channel
    add_index :pug_ormp_message_accepteds, :e_message_index
    add_index :pug_ormp_message_accepteds, :e_message_from_chain_id
    add_index :pug_ormp_message_accepteds, :e_message_from
    add_index :pug_ormp_message_accepteds, :e_message_to_chain_id
    add_index :pug_ormp_message_accepteds, :e_message_to
    add_index :pug_ormp_message_accepteds, :e_message_encoded
  end
end
