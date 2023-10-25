class CreatePugSubApiOwnershipTransferStarteds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_sub_api_ownership_transfer_starteds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.string :p_previous_owner
      t.string :p_new_owner
    end
    add_index :pug_sub_api_ownership_transfer_starteds, :p_previous_owner
    add_index :pug_sub_api_ownership_transfer_starteds, :p_new_owner
  end
end
