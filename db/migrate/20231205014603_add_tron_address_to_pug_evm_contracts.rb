class AddTronAddressToPugEvmContracts < ActiveRecord::Migration[7.1]
  def change
    add_column :pug_evm_contracts, :tron_address, :string
  end
end
