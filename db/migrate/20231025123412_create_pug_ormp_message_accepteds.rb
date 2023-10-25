class CreatePugOrmpMessageAccepteds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_ormp_message_accepteds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :msg_hash
      t.string :root
      t.string :message_channel
      t.decimal :message_index, precision: 78, scale: 0
      t.decimal :message_from_chain_id, precision: 78, scale: 0
      t.string :message_from
      t.decimal :message_to_chain_id, precision: 78, scale: 0
      t.string :message_to
      t.string :message_encoded

      t.timestamps
    end
    add_index :pug_ormp_message_accepteds, :msg_hash
    add_index :pug_ormp_message_accepteds, :root
    add_index :pug_ormp_message_accepteds, :message_channel
    add_index :pug_ormp_message_accepteds, :message_index
    add_index :pug_ormp_message_accepteds, :message_from_chain_id
    add_index :pug_ormp_message_accepteds, :message_from
    add_index :pug_ormp_message_accepteds, :message_to_chain_id
    add_index :pug_ormp_message_accepteds, :message_to
    add_index :pug_ormp_message_accepteds, :message_encoded
  end
end
