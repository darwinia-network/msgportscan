class CreatePugSubApiOwnershipTransferreds < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_sub_api_ownership_transferreds do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.belongs_to :pug_evm_contract, null: false, foreign_key: true
      t.belongs_to :pug_network, null: false, foreign_key: true
      t.string :previous_owner
      t.string :new_owner

      t.timestamps
    end
    add_index :pug_sub_api_ownership_transferreds, :previous_owner
    add_index :pug_sub_api_ownership_transferreds, :new_owner
  end
end
