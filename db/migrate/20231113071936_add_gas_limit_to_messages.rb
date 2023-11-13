class AddGasLimitToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :gas_limit, :bigint
  end
end
