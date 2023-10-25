# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_10_25_072305) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pug_evm_contracts", force: :cascade do |t|
    t.integer "network_id"
    t.string "address"
    t.string "abi_file"
    t.string "creator"
    t.integer "creation_block"
    t.string "creation_tx_hash"
    t.datetime "creation_timestamp"
    t.integer "last_scanned_block"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["network_id", "address"], name: "index_pug_evm_contracts_on_network_id_and_address", unique: true
  end

  create_table "pug_evm_logs", force: :cascade do |t|
    t.integer "network_id"
    t.integer "evm_contract_id"
    t.string "address"
    t.text "data"
    t.string "block_hash"
    t.integer "block_number"
    t.string "transaction_hash"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "timestamp"
    t.string "topic0"
    t.string "topic1"
    t.string "topic2"
    t.string "topic3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_network_id_block_number_transaction_index_lo_603ca303c9", unique: true
    t.index ["topic0"], name: "index_pug_evm_logs_on_topic0"
    t.index ["topic1"], name: "index_pug_evm_logs_on_topic1"
    t.index ["topic2"], name: "index_pug_evm_logs_on_topic2"
    t.index ["topic3"], name: "index_pug_evm_logs_on_topic3"
  end

  create_table "pug_networks", force: :cascade do |t|
    t.bigint "chain_id"
    t.string "name"
    t.string "display_name"
    t.json "rpc_list"
    t.integer "scan_span", default: 5000
    t.integer "last_scanned_block", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pug_oracle_assigneds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.string "p_msg_hash"
    t.decimal "p_fee", precision: 78
    t.index ["p_fee"], name: "index_pug_oracle_assigneds_on_p_fee"
    t.index ["p_msg_hash"], name: "index_pug_oracle_assigneds_on_p_msg_hash"
    t.index ["pug_evm_log_id"], name: "index_pug_oracle_assigneds_on_pug_evm_log_id"
  end

  create_table "pug_oracle_set_approveds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.string "p_operator"
    t.boolean "p_approve"
    t.index ["p_approve"], name: "index_pug_oracle_set_approveds_on_p_approve"
    t.index ["p_operator"], name: "index_pug_oracle_set_approveds_on_p_operator"
    t.index ["pug_evm_log_id"], name: "index_pug_oracle_set_approveds_on_pug_evm_log_id"
  end

  create_table "pug_oracle_set_dapis", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.decimal "p_chain_id", precision: 78
    t.string "p_dapi"
    t.index ["p_chain_id"], name: "index_pug_oracle_set_dapis_on_p_chain_id"
    t.index ["p_dapi"], name: "index_pug_oracle_set_dapis_on_p_dapi"
    t.index ["pug_evm_log_id"], name: "index_pug_oracle_set_dapis_on_pug_evm_log_id"
  end

  create_table "pug_oracle_set_fees", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.decimal "p_chain_id", precision: 78
    t.decimal "p_fee", precision: 78
    t.index ["p_chain_id"], name: "index_pug_oracle_set_fees_on_p_chain_id"
    t.index ["p_fee"], name: "index_pug_oracle_set_fees_on_p_fee"
    t.index ["pug_evm_log_id"], name: "index_pug_oracle_set_fees_on_pug_evm_log_id"
  end

  create_table "pug_ormp_app_config_updateds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.string "p_ua"
    t.string "p_oracle"
    t.string "p_relayer"
    t.index ["p_oracle"], name: "index_pug_ormp_app_config_updateds_on_p_oracle"
    t.index ["p_relayer"], name: "index_pug_ormp_app_config_updateds_on_p_relayer"
    t.index ["p_ua"], name: "index_pug_ormp_app_config_updateds_on_p_ua"
    t.index ["pug_evm_log_id"], name: "index_pug_ormp_app_config_updateds_on_pug_evm_log_id"
  end

  create_table "pug_ormp_clear_failed_messages", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.string "p_msg_hash"
    t.index ["p_msg_hash"], name: "index_pug_ormp_clear_failed_messages_on_p_msg_hash"
    t.index ["pug_evm_log_id"], name: "index_pug_ormp_clear_failed_messages_on_pug_evm_log_id"
  end

  create_table "pug_ormp_message_accepteds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.string "p_msg_hash"
    t.string "p_root"
    t.string "p_message_channel"
    t.decimal "p_message_index", precision: 78
    t.decimal "p_message_from_chain_id", precision: 78
    t.string "p_message_from"
    t.decimal "p_message_to_chain_id", precision: 78
    t.string "p_message_to"
    t.string "p_message_encoded"
    t.index ["p_message_channel"], name: "index_pug_ormp_message_accepteds_on_p_message_channel"
    t.index ["p_message_encoded"], name: "index_pug_ormp_message_accepteds_on_p_message_encoded"
    t.index ["p_message_from"], name: "index_pug_ormp_message_accepteds_on_p_message_from"
    t.index ["p_message_from_chain_id"], name: "index_pug_ormp_message_accepteds_on_p_message_from_chain_id"
    t.index ["p_message_index"], name: "index_pug_ormp_message_accepteds_on_p_message_index"
    t.index ["p_message_to"], name: "index_pug_ormp_message_accepteds_on_p_message_to"
    t.index ["p_message_to_chain_id"], name: "index_pug_ormp_message_accepteds_on_p_message_to_chain_id"
    t.index ["p_msg_hash"], name: "index_pug_ormp_message_accepteds_on_p_msg_hash"
    t.index ["p_root"], name: "index_pug_ormp_message_accepteds_on_p_root"
    t.index ["pug_evm_log_id"], name: "index_pug_ormp_message_accepteds_on_pug_evm_log_id"
  end

  create_table "pug_ormp_message_dispatcheds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.string "p_msg_hash"
    t.boolean "p_dispatch_result"
    t.index ["p_dispatch_result"], name: "index_pug_ormp_message_dispatcheds_on_p_dispatch_result"
    t.index ["p_msg_hash"], name: "index_pug_ormp_message_dispatcheds_on_p_msg_hash"
    t.index ["pug_evm_log_id"], name: "index_pug_ormp_message_dispatcheds_on_pug_evm_log_id"
  end

  create_table "pug_ormp_retry_failed_messages", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.string "p_msg_hash"
    t.boolean "p_dispatch_result"
    t.index ["p_dispatch_result"], name: "index_pug_ormp_retry_failed_messages_on_p_dispatch_result"
    t.index ["p_msg_hash"], name: "index_pug_ormp_retry_failed_messages_on_p_msg_hash"
    t.index ["pug_evm_log_id"], name: "index_pug_ormp_retry_failed_messages_on_pug_evm_log_id"
  end

  create_table "pug_ormp_set_default_configs", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.string "p_oracle"
    t.string "p_relayer"
    t.index ["p_oracle"], name: "index_pug_ormp_set_default_configs_on_p_oracle"
    t.index ["p_relayer"], name: "index_pug_ormp_set_default_configs_on_p_relayer"
    t.index ["pug_evm_log_id"], name: "index_pug_ormp_set_default_configs_on_pug_evm_log_id"
  end

  create_table "pug_relayer_assigneds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.string "p_msg_hash"
    t.decimal "p_fee", precision: 78
    t.string "p_params"
    t.string "p_proof"
    t.index ["p_fee"], name: "index_pug_relayer_assigneds_on_p_fee"
    t.index ["p_msg_hash"], name: "index_pug_relayer_assigneds_on_p_msg_hash"
    t.index ["p_params"], name: "index_pug_relayer_assigneds_on_p_params"
    t.index ["p_proof"], name: "index_pug_relayer_assigneds_on_p_proof"
    t.index ["pug_evm_log_id"], name: "index_pug_relayer_assigneds_on_pug_evm_log_id"
  end

  create_table "pug_relayer_set_approveds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.string "p_operator"
    t.boolean "p_approve"
    t.index ["p_approve"], name: "index_pug_relayer_set_approveds_on_p_approve"
    t.index ["p_operator"], name: "index_pug_relayer_set_approveds_on_p_operator"
    t.index ["pug_evm_log_id"], name: "index_pug_relayer_set_approveds_on_pug_evm_log_id"
  end

  create_table "pug_relayer_set_dst_configs", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.decimal "p_chain_id", precision: 78
    t.decimal "p_base_gas", precision: 20
    t.decimal "p_gas_per_byte", precision: 20
    t.index ["p_base_gas"], name: "index_pug_relayer_set_dst_configs_on_p_base_gas"
    t.index ["p_chain_id"], name: "index_pug_relayer_set_dst_configs_on_p_chain_id"
    t.index ["p_gas_per_byte"], name: "index_pug_relayer_set_dst_configs_on_p_gas_per_byte"
    t.index ["pug_evm_log_id"], name: "index_pug_relayer_set_dst_configs_on_pug_evm_log_id"
  end

  create_table "pug_relayer_set_dst_prices", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.decimal "p_chain_id", precision: 78
    t.decimal "p_dst_price_ratio", precision: 39
    t.decimal "p_dst_gas_price_in_wei", precision: 39
    t.index ["p_chain_id"], name: "index_pug_relayer_set_dst_prices_on_p_chain_id"
    t.index ["p_dst_gas_price_in_wei"], name: "index_pug_relayer_set_dst_prices_on_p_dst_gas_price_in_wei"
    t.index ["p_dst_price_ratio"], name: "index_pug_relayer_set_dst_prices_on_p_dst_price_ratio"
    t.index ["pug_evm_log_id"], name: "index_pug_relayer_set_dst_prices_on_pug_evm_log_id"
  end

  create_table "pug_sub_api_add_beacons", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.string "p_beacon_id"
    t.string "p_beacon_airnode"
    t.string "p_beacon_endpoint_id"
    t.string "p_beacon_sponsor"
    t.string "p_beacon_sponsor_wallet"
    t.index ["p_beacon_airnode"], name: "index_pug_sub_api_add_beacons_on_p_beacon_airnode"
    t.index ["p_beacon_endpoint_id"], name: "index_pug_sub_api_add_beacons_on_p_beacon_endpoint_id"
    t.index ["p_beacon_id"], name: "index_pug_sub_api_add_beacons_on_p_beacon_id"
    t.index ["p_beacon_sponsor"], name: "index_pug_sub_api_add_beacons_on_p_beacon_sponsor"
    t.index ["p_beacon_sponsor_wallet"], name: "index_pug_sub_api_add_beacons_on_p_beacon_sponsor_wallet"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_add_beacons_on_pug_evm_log_id"
  end

  create_table "pug_sub_api_aggregated_ormp_data", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.decimal "p_ormp_data_count", precision: 78
    t.string "p_ormp_data_root"
    t.index ["p_ormp_data_count"], name: "index_pug_sub_api_aggregated_ormp_data_on_p_ormp_data_count"
    t.index ["p_ormp_data_root"], name: "index_pug_sub_api_aggregated_ormp_data_on_p_ormp_data_root"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_aggregated_ormp_data_on_pug_evm_log_id"
  end

  create_table "pug_sub_api_airnode_rrp_completeds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.string "p_beacon_id"
    t.string "p_request_id"
    t.string "p_data"
    t.index ["p_beacon_id"], name: "index_pug_sub_api_airnode_rrp_completeds_on_p_beacon_id"
    t.index ["p_data"], name: "index_pug_sub_api_airnode_rrp_completeds_on_p_data"
    t.index ["p_request_id"], name: "index_pug_sub_api_airnode_rrp_completeds_on_p_request_id"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_airnode_rrp_completeds_on_pug_evm_log_id"
  end

  create_table "pug_sub_api_airnode_rrp_requesteds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.string "p_beacon_id"
    t.string "p_request_id"
    t.index ["p_beacon_id"], name: "index_pug_sub_api_airnode_rrp_requesteds_on_p_beacon_id"
    t.index ["p_request_id"], name: "index_pug_sub_api_airnode_rrp_requesteds_on_p_request_id"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_airnode_rrp_requesteds_on_pug_evm_log_id"
  end

  create_table "pug_sub_api_ownership_transfer_starteds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.string "p_previous_owner"
    t.string "p_new_owner"
    t.index ["p_new_owner"], name: "index_pug_sub_api_ownership_transfer_starteds_on_p_new_owner"
    t.index ["p_previous_owner"], name: "idx_on_p_previous_owner_e6c82aa4f9"
    t.index ["pug_evm_log_id"], name: "idx_on_pug_evm_log_id_4fb906a4ae"
  end

  create_table "pug_sub_api_ownership_transferreds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.string "p_previous_owner"
    t.string "p_new_owner"
    t.index ["p_new_owner"], name: "index_pug_sub_api_ownership_transferreds_on_p_new_owner"
    t.index ["p_previous_owner"], name: "index_pug_sub_api_ownership_transferreds_on_p_previous_owner"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_ownership_transferreds_on_pug_evm_log_id"
  end

  create_table "pug_sub_api_remove_beacons", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.string "p_beacon_id"
    t.index ["p_beacon_id"], name: "index_pug_sub_api_remove_beacons_on_p_beacon_id"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_remove_beacons_on_pug_evm_log_id"
  end

  create_table "pug_sub_api_sub_api_feed_updateds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.string "p_beacon_id"
    t.decimal "p_msg_root_count", precision: 78
    t.string "p_msg_root_root"
    t.index ["p_beacon_id"], name: "index_pug_sub_api_sub_api_feed_updateds_on_p_beacon_id"
    t.index ["p_msg_root_count"], name: "index_pug_sub_api_sub_api_feed_updateds_on_p_msg_root_count"
    t.index ["p_msg_root_root"], name: "index_pug_sub_api_sub_api_feed_updateds_on_p_msg_root_root"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_sub_api_feed_updateds_on_pug_evm_log_id"
  end

  add_foreign_key "pug_oracle_assigneds", "pug_evm_logs"
  add_foreign_key "pug_oracle_set_approveds", "pug_evm_logs"
  add_foreign_key "pug_oracle_set_dapis", "pug_evm_logs"
  add_foreign_key "pug_oracle_set_fees", "pug_evm_logs"
  add_foreign_key "pug_ormp_app_config_updateds", "pug_evm_logs"
  add_foreign_key "pug_ormp_clear_failed_messages", "pug_evm_logs"
  add_foreign_key "pug_ormp_message_accepteds", "pug_evm_logs"
  add_foreign_key "pug_ormp_message_dispatcheds", "pug_evm_logs"
  add_foreign_key "pug_ormp_retry_failed_messages", "pug_evm_logs"
  add_foreign_key "pug_ormp_set_default_configs", "pug_evm_logs"
  add_foreign_key "pug_relayer_assigneds", "pug_evm_logs"
  add_foreign_key "pug_relayer_set_approveds", "pug_evm_logs"
  add_foreign_key "pug_relayer_set_dst_configs", "pug_evm_logs"
  add_foreign_key "pug_relayer_set_dst_prices", "pug_evm_logs"
  add_foreign_key "pug_sub_api_add_beacons", "pug_evm_logs"
  add_foreign_key "pug_sub_api_aggregated_ormp_data", "pug_evm_logs"
  add_foreign_key "pug_sub_api_airnode_rrp_completeds", "pug_evm_logs"
  add_foreign_key "pug_sub_api_airnode_rrp_requesteds", "pug_evm_logs"
  add_foreign_key "pug_sub_api_ownership_transfer_starteds", "pug_evm_logs"
  add_foreign_key "pug_sub_api_ownership_transferreds", "pug_evm_logs"
  add_foreign_key "pug_sub_api_remove_beacons", "pug_evm_logs"
  add_foreign_key "pug_sub_api_sub_api_feed_updateds", "pug_evm_logs"
end
