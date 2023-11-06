class AddNameToPugEvmContracts < ActiveRecord::Migration[7.1]
  def change
    add_column :pug_evm_contracts, :name, :string
  end
end
