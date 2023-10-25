class CreatePugOrmpRetryFailedMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :pug_ormp_retry_failed_messages do |t|
      t.belongs_to :pug_evm_log, null: false, foreign_key: true
      t.string :p_msg_hash
      t.boolean :p_dispatch_result
    end
    add_index :pug_ormp_retry_failed_messages, :p_msg_hash
    add_index :pug_ormp_retry_failed_messages, :p_dispatch_result
  end
end
