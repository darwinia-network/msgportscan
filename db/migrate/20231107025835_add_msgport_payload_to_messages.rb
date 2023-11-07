class AddMsgportPayloadToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :msgport_payload, :text
    add_column :messages, :msgport_from, :string
    add_column :messages, :msgport_to, :string
  end
end
