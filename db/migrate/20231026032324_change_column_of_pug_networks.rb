class ChangeColumnOfPugNetworks < ActiveRecord::Migration[7.1]
  def change
    remove_column :pug_networks, :rpc_list, :json
    add_column :pug_networks, :rpc, :string
  end
end
