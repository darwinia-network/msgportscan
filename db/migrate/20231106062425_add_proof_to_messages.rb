class AddProofToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :proof, :json
  end
end
