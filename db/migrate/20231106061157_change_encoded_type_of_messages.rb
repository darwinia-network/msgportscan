class ChangeEncodedTypeOfMessages < ActiveRecord::Migration[7.1]
  def up
    change_column :messages, :encoded, :text
  end

  def down
    change_column :messages, :encoded, :string
  end
end
