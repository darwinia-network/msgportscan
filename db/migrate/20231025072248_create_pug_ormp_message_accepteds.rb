class CreatePugOrmpMessageAccepteds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_ormp_message_accepteds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.string :p_msg_hash
      t.string :p_root
      t.string :p_message_channel
      t.decimal :p_message_index, precision: 78, scale: 0
      t.decimal :p_message_from_chain_id, precision: 78, scale: 0
      t.string :p_message_from
      t.decimal :p_message_to_chain_id, precision: 78, scale: 0
      t.string :p_message_to
      t.string :p_message_encoded
    end
    add_index :pug_ormp_message_accepteds, :p_msg_hash
    add_index :pug_ormp_message_accepteds, :p_root
    add_index :pug_ormp_message_accepteds, :p_message_channel
    add_index :pug_ormp_message_accepteds, :p_message_index
    add_index :pug_ormp_message_accepteds, :p_message_from_chain_id
    add_index :pug_ormp_message_accepteds, :p_message_from
    add_index :pug_ormp_message_accepteds, :p_message_to_chain_id
    add_index :pug_ormp_message_accepteds, :p_message_to
    add_index :pug_ormp_message_accepteds, :p_message_encoded
  end
end
