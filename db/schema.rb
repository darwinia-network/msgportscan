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

ActiveRecord::Schema[7.1].define(version: 2023_10_30_235154) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "messages", force: :cascade do |t|
    t.integer "index"
    t.string "msg_hash"
    t.string "root"
    t.string "channel"
    t.integer "from_chain_id"
    t.string "from"
    t.integer "to_chain_id"
    t.string "to"
    t.integer "block_number"
    t.integer "block_timestamp"
    t.string "transaction_hash"
    t.integer "status"
    t.string "encoded"
    t.integer "from_network_id"
    t.integer "to_network_id"
    t.string "dispatch_transaction_hash"
    t.integer "dispatch_block_number"
    t.integer "dispatch_block_timestamp"
    t.string "clear_transaction_hash"
    t.integer "clear_block_number"
    t.integer "clear_block_timestamp"
    t.index ["msg_hash"], name: "index_messages_on_msg_hash", unique: true
    t.index ["root"], name: "index_messages_on_root", unique: true
  end

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
    t.string "rpc"
    t.string "explorer"
    t.integer "scan_span", default: 5000
    t.integer "last_scanned_block", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pug_oracle_assigneds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "msg_hash"
    t.decimal "fee", precision: 78
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["fee"], name: "index_pug_oracle_assigneds_on_fee"
    t.index ["msg_hash"], name: "index_pug_oracle_assigneds_on_msg_hash"
    t.index ["pug_evm_contract_id"], name: "index_pug_oracle_assigneds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_oracle_assigneds_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_oracle_assigneds_on_pug_network_id"
  end

  create_table "pug_oracle_set_approveds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "operator"
    t.boolean "approve"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["approve"], name: "index_pug_oracle_set_approveds_on_approve"
    t.index ["operator"], name: "index_pug_oracle_set_approveds_on_operator"
    t.index ["pug_evm_contract_id"], name: "index_pug_oracle_set_approveds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_oracle_set_approveds_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_oracle_set_approveds_on_pug_network_id"
  end

  create_table "pug_oracle_set_dapis", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.decimal "chain_id", precision: 78
    t.string "dapi"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["chain_id"], name: "index_pug_oracle_set_dapis_on_chain_id"
    t.index ["dapi"], name: "index_pug_oracle_set_dapis_on_dapi"
    t.index ["pug_evm_contract_id"], name: "index_pug_oracle_set_dapis_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_oracle_set_dapis_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_oracle_set_dapis_on_pug_network_id"
  end

  create_table "pug_oracle_set_fees", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.decimal "chain_id", precision: 78
    t.decimal "fee", precision: 78
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["chain_id"], name: "index_pug_oracle_set_fees_on_chain_id"
    t.index ["fee"], name: "index_pug_oracle_set_fees_on_fee"
    t.index ["pug_evm_contract_id"], name: "index_pug_oracle_set_fees_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_oracle_set_fees_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_oracle_set_fees_on_pug_network_id"
  end

  create_table "pug_ormp_app_config_updateds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "ua"
    t.string "oracle"
    t.string "relayer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["oracle"], name: "index_pug_ormp_app_config_updateds_on_oracle"
    t.index ["pug_evm_contract_id"], name: "index_pug_ormp_app_config_updateds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_ormp_app_config_updateds_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_ormp_app_config_updateds_on_pug_network_id"
    t.index ["relayer"], name: "index_pug_ormp_app_config_updateds_on_relayer"
    t.index ["ua"], name: "index_pug_ormp_app_config_updateds_on_ua"
  end

  create_table "pug_ormp_clear_failed_messages", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "msg_hash"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["msg_hash"], name: "index_pug_ormp_clear_failed_messages_on_msg_hash"
    t.index ["pug_evm_contract_id"], name: "index_pug_ormp_clear_failed_messages_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_ormp_clear_failed_messages_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_ormp_clear_failed_messages_on_pug_network_id"
  end

  create_table "pug_ormp_message_accepteds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "msg_hash"
    t.string "root"
    t.string "message_channel"
    t.decimal "message_index", precision: 78
    t.decimal "message_from_chain_id", precision: 78
    t.string "message_from"
    t.decimal "message_to_chain_id", precision: 78
    t.string "message_to"
    t.string "message_encoded"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["message_channel"], name: "index_pug_ormp_message_accepteds_on_message_channel"
    t.index ["message_encoded"], name: "index_pug_ormp_message_accepteds_on_message_encoded"
    t.index ["message_from"], name: "index_pug_ormp_message_accepteds_on_message_from"
    t.index ["message_from_chain_id"], name: "index_pug_ormp_message_accepteds_on_message_from_chain_id"
    t.index ["message_index"], name: "index_pug_ormp_message_accepteds_on_message_index"
    t.index ["message_to"], name: "index_pug_ormp_message_accepteds_on_message_to"
    t.index ["message_to_chain_id"], name: "index_pug_ormp_message_accepteds_on_message_to_chain_id"
    t.index ["msg_hash"], name: "index_pug_ormp_message_accepteds_on_msg_hash"
    t.index ["pug_evm_contract_id"], name: "index_pug_ormp_message_accepteds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_ormp_message_accepteds_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_ormp_message_accepteds_on_pug_network_id"
    t.index ["root"], name: "index_pug_ormp_message_accepteds_on_root"
  end

  create_table "pug_ormp_message_dispatcheds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "msg_hash"
    t.boolean "dispatch_result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["dispatch_result"], name: "index_pug_ormp_message_dispatcheds_on_dispatch_result"
    t.index ["msg_hash"], name: "index_pug_ormp_message_dispatcheds_on_msg_hash"
    t.index ["pug_evm_contract_id"], name: "index_pug_ormp_message_dispatcheds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_ormp_message_dispatcheds_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_ormp_message_dispatcheds_on_pug_network_id"
  end

  create_table "pug_ormp_retry_failed_messages", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "msg_hash"
    t.boolean "dispatch_result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["dispatch_result"], name: "index_pug_ormp_retry_failed_messages_on_dispatch_result"
    t.index ["msg_hash"], name: "index_pug_ormp_retry_failed_messages_on_msg_hash"
    t.index ["pug_evm_contract_id"], name: "index_pug_ormp_retry_failed_messages_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_ormp_retry_failed_messages_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_ormp_retry_failed_messages_on_pug_network_id"
  end

  create_table "pug_ormp_set_default_configs", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "oracle"
    t.string "relayer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["oracle"], name: "index_pug_ormp_set_default_configs_on_oracle"
    t.index ["pug_evm_contract_id"], name: "index_pug_ormp_set_default_configs_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_ormp_set_default_configs_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_ormp_set_default_configs_on_pug_network_id"
    t.index ["relayer"], name: "index_pug_ormp_set_default_configs_on_relayer"
  end

  create_table "pug_relayer_assigneds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "msg_hash"
    t.decimal "fee", precision: 78
    t.string "params"
    t.string "proof"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["fee"], name: "index_pug_relayer_assigneds_on_fee"
    t.index ["msg_hash"], name: "index_pug_relayer_assigneds_on_msg_hash"
    t.index ["params"], name: "index_pug_relayer_assigneds_on_params"
    t.index ["proof"], name: "index_pug_relayer_assigneds_on_proof"
    t.index ["pug_evm_contract_id"], name: "index_pug_relayer_assigneds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_relayer_assigneds_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_relayer_assigneds_on_pug_network_id"
  end

  create_table "pug_relayer_set_approveds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "operator"
    t.boolean "approve"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["approve"], name: "index_pug_relayer_set_approveds_on_approve"
    t.index ["operator"], name: "index_pug_relayer_set_approveds_on_operator"
    t.index ["pug_evm_contract_id"], name: "index_pug_relayer_set_approveds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_relayer_set_approveds_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_relayer_set_approveds_on_pug_network_id"
  end

  create_table "pug_relayer_set_dst_configs", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.decimal "chain_id", precision: 78
    t.decimal "base_gas", precision: 20
    t.decimal "gas_per_byte", precision: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["base_gas"], name: "index_pug_relayer_set_dst_configs_on_base_gas"
    t.index ["chain_id"], name: "index_pug_relayer_set_dst_configs_on_chain_id"
    t.index ["gas_per_byte"], name: "index_pug_relayer_set_dst_configs_on_gas_per_byte"
    t.index ["pug_evm_contract_id"], name: "index_pug_relayer_set_dst_configs_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_relayer_set_dst_configs_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_relayer_set_dst_configs_on_pug_network_id"
  end

  create_table "pug_relayer_set_dst_prices", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.decimal "chain_id", precision: 78
    t.decimal "dst_price_ratio", precision: 39
    t.decimal "dst_gas_price_in_wei", precision: 39
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["chain_id"], name: "index_pug_relayer_set_dst_prices_on_chain_id"
    t.index ["dst_gas_price_in_wei"], name: "index_pug_relayer_set_dst_prices_on_dst_gas_price_in_wei"
    t.index ["dst_price_ratio"], name: "index_pug_relayer_set_dst_prices_on_dst_price_ratio"
    t.index ["pug_evm_contract_id"], name: "index_pug_relayer_set_dst_prices_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_relayer_set_dst_prices_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_relayer_set_dst_prices_on_pug_network_id"
  end

  create_table "pug_sub_api_add_beacons", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "beacon_id"
    t.string "beacon_airnode"
    t.string "beacon_endpoint_id"
    t.string "beacon_sponsor"
    t.string "beacon_sponsor_wallet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["beacon_airnode"], name: "index_pug_sub_api_add_beacons_on_beacon_airnode"
    t.index ["beacon_endpoint_id"], name: "index_pug_sub_api_add_beacons_on_beacon_endpoint_id"
    t.index ["beacon_id"], name: "index_pug_sub_api_add_beacons_on_beacon_id"
    t.index ["beacon_sponsor"], name: "index_pug_sub_api_add_beacons_on_beacon_sponsor"
    t.index ["beacon_sponsor_wallet"], name: "index_pug_sub_api_add_beacons_on_beacon_sponsor_wallet"
    t.index ["pug_evm_contract_id"], name: "index_pug_sub_api_add_beacons_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_add_beacons_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_sub_api_add_beacons_on_pug_network_id"
  end

  create_table "pug_sub_api_aggregated_ormp_data", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.decimal "ormp_data_count", precision: 78
    t.string "ormp_data_root"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["ormp_data_count"], name: "index_pug_sub_api_aggregated_ormp_data_on_ormp_data_count"
    t.index ["ormp_data_root"], name: "index_pug_sub_api_aggregated_ormp_data_on_ormp_data_root"
    t.index ["pug_evm_contract_id"], name: "index_pug_sub_api_aggregated_ormp_data_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_aggregated_ormp_data_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_sub_api_aggregated_ormp_data_on_pug_network_id"
  end

  create_table "pug_sub_api_airnode_rrp_completeds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "beacon_id"
    t.string "request_id"
    t.string "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["beacon_id"], name: "index_pug_sub_api_airnode_rrp_completeds_on_beacon_id"
    t.index ["data"], name: "index_pug_sub_api_airnode_rrp_completeds_on_data"
    t.index ["pug_evm_contract_id"], name: "idx_on_pug_evm_contract_id_7d68e35ef3"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_airnode_rrp_completeds_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_sub_api_airnode_rrp_completeds_on_pug_network_id"
    t.index ["request_id"], name: "index_pug_sub_api_airnode_rrp_completeds_on_request_id"
  end

  create_table "pug_sub_api_airnode_rrp_requesteds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "beacon_id"
    t.string "request_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["beacon_id"], name: "index_pug_sub_api_airnode_rrp_requesteds_on_beacon_id"
    t.index ["pug_evm_contract_id"], name: "idx_on_pug_evm_contract_id_7f90448c42"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_airnode_rrp_requesteds_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_sub_api_airnode_rrp_requesteds_on_pug_network_id"
    t.index ["request_id"], name: "index_pug_sub_api_airnode_rrp_requesteds_on_request_id"
  end

  create_table "pug_sub_api_ownership_transfer_starteds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "previous_owner"
    t.string "new_owner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["new_owner"], name: "index_pug_sub_api_ownership_transfer_starteds_on_new_owner"
    t.index ["previous_owner"], name: "idx_on_previous_owner_093a3cf06e"
    t.index ["pug_evm_contract_id"], name: "idx_on_pug_evm_contract_id_07fc2e2c5b"
    t.index ["pug_evm_log_id"], name: "idx_on_pug_evm_log_id_4fb906a4ae"
    t.index ["pug_network_id"], name: "idx_on_pug_network_id_e9d99d14c5"
  end

  create_table "pug_sub_api_ownership_transferreds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "previous_owner"
    t.string "new_owner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["new_owner"], name: "index_pug_sub_api_ownership_transferreds_on_new_owner"
    t.index ["previous_owner"], name: "index_pug_sub_api_ownership_transferreds_on_previous_owner"
    t.index ["pug_evm_contract_id"], name: "idx_on_pug_evm_contract_id_53307178ad"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_ownership_transferreds_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_sub_api_ownership_transferreds_on_pug_network_id"
  end

  create_table "pug_sub_api_remove_beacons", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "beacon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["beacon_id"], name: "index_pug_sub_api_remove_beacons_on_beacon_id"
    t.index ["pug_evm_contract_id"], name: "index_pug_sub_api_remove_beacons_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_remove_beacons_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_sub_api_remove_beacons_on_pug_network_id"
  end

  create_table "pug_sub_api_sub_api_feed_updateds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "beacon_id"
    t.decimal "msg_root_count", precision: 78
    t.string "msg_root_root"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "block_number"
    t.datetime "timestamp"
    t.index ["beacon_id"], name: "index_pug_sub_api_sub_api_feed_updateds_on_beacon_id"
    t.index ["msg_root_count"], name: "index_pug_sub_api_sub_api_feed_updateds_on_msg_root_count"
    t.index ["msg_root_root"], name: "index_pug_sub_api_sub_api_feed_updateds_on_msg_root_root"
    t.index ["pug_evm_contract_id"], name: "index_pug_sub_api_sub_api_feed_updateds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_sub_api_feed_updateds_on_pug_evm_log_id"
    t.index ["pug_network_id"], name: "index_pug_sub_api_sub_api_feed_updateds_on_pug_network_id"
  end

  add_foreign_key "pug_oracle_assigneds", "pug_evm_contracts"
  add_foreign_key "pug_oracle_assigneds", "pug_evm_logs"
  add_foreign_key "pug_oracle_assigneds", "pug_networks"
  add_foreign_key "pug_oracle_set_approveds", "pug_evm_contracts"
  add_foreign_key "pug_oracle_set_approveds", "pug_evm_logs"
  add_foreign_key "pug_oracle_set_approveds", "pug_networks"
  add_foreign_key "pug_oracle_set_dapis", "pug_evm_contracts"
  add_foreign_key "pug_oracle_set_dapis", "pug_evm_logs"
  add_foreign_key "pug_oracle_set_dapis", "pug_networks"
  add_foreign_key "pug_oracle_set_fees", "pug_evm_contracts"
  add_foreign_key "pug_oracle_set_fees", "pug_evm_logs"
  add_foreign_key "pug_oracle_set_fees", "pug_networks"
  add_foreign_key "pug_ormp_app_config_updateds", "pug_evm_contracts"
  add_foreign_key "pug_ormp_app_config_updateds", "pug_evm_logs"
  add_foreign_key "pug_ormp_app_config_updateds", "pug_networks"
  add_foreign_key "pug_ormp_clear_failed_messages", "pug_evm_contracts"
  add_foreign_key "pug_ormp_clear_failed_messages", "pug_evm_logs"
  add_foreign_key "pug_ormp_clear_failed_messages", "pug_networks"
  add_foreign_key "pug_ormp_message_accepteds", "pug_evm_contracts"
  add_foreign_key "pug_ormp_message_accepteds", "pug_evm_logs"
  add_foreign_key "pug_ormp_message_accepteds", "pug_networks"
  add_foreign_key "pug_ormp_message_dispatcheds", "pug_evm_contracts"
  add_foreign_key "pug_ormp_message_dispatcheds", "pug_evm_logs"
  add_foreign_key "pug_ormp_message_dispatcheds", "pug_networks"
  add_foreign_key "pug_ormp_retry_failed_messages", "pug_evm_contracts"
  add_foreign_key "pug_ormp_retry_failed_messages", "pug_evm_logs"
  add_foreign_key "pug_ormp_retry_failed_messages", "pug_networks"
  add_foreign_key "pug_ormp_set_default_configs", "pug_evm_contracts"
  add_foreign_key "pug_ormp_set_default_configs", "pug_evm_logs"
  add_foreign_key "pug_ormp_set_default_configs", "pug_networks"
  add_foreign_key "pug_relayer_assigneds", "pug_evm_contracts"
  add_foreign_key "pug_relayer_assigneds", "pug_evm_logs"
  add_foreign_key "pug_relayer_assigneds", "pug_networks"
  add_foreign_key "pug_relayer_set_approveds", "pug_evm_contracts"
  add_foreign_key "pug_relayer_set_approveds", "pug_evm_logs"
  add_foreign_key "pug_relayer_set_approveds", "pug_networks"
  add_foreign_key "pug_relayer_set_dst_configs", "pug_evm_contracts"
  add_foreign_key "pug_relayer_set_dst_configs", "pug_evm_logs"
  add_foreign_key "pug_relayer_set_dst_configs", "pug_networks"
  add_foreign_key "pug_relayer_set_dst_prices", "pug_evm_contracts"
  add_foreign_key "pug_relayer_set_dst_prices", "pug_evm_logs"
  add_foreign_key "pug_relayer_set_dst_prices", "pug_networks"
  add_foreign_key "pug_sub_api_add_beacons", "pug_evm_contracts"
  add_foreign_key "pug_sub_api_add_beacons", "pug_evm_logs"
  add_foreign_key "pug_sub_api_add_beacons", "pug_networks"
  add_foreign_key "pug_sub_api_aggregated_ormp_data", "pug_evm_contracts"
  add_foreign_key "pug_sub_api_aggregated_ormp_data", "pug_evm_logs"
  add_foreign_key "pug_sub_api_aggregated_ormp_data", "pug_networks"
  add_foreign_key "pug_sub_api_airnode_rrp_completeds", "pug_evm_contracts"
  add_foreign_key "pug_sub_api_airnode_rrp_completeds", "pug_evm_logs"
  add_foreign_key "pug_sub_api_airnode_rrp_completeds", "pug_networks"
  add_foreign_key "pug_sub_api_airnode_rrp_requesteds", "pug_evm_contracts"
  add_foreign_key "pug_sub_api_airnode_rrp_requesteds", "pug_evm_logs"
  add_foreign_key "pug_sub_api_airnode_rrp_requesteds", "pug_networks"
  add_foreign_key "pug_sub_api_ownership_transfer_starteds", "pug_evm_contracts"
  add_foreign_key "pug_sub_api_ownership_transfer_starteds", "pug_evm_logs"
  add_foreign_key "pug_sub_api_ownership_transfer_starteds", "pug_networks"
  add_foreign_key "pug_sub_api_ownership_transferreds", "pug_evm_contracts"
  add_foreign_key "pug_sub_api_ownership_transferreds", "pug_evm_logs"
  add_foreign_key "pug_sub_api_ownership_transferreds", "pug_networks"
  add_foreign_key "pug_sub_api_remove_beacons", "pug_evm_contracts"
  add_foreign_key "pug_sub_api_remove_beacons", "pug_evm_logs"
  add_foreign_key "pug_sub_api_remove_beacons", "pug_networks"
  add_foreign_key "pug_sub_api_sub_api_feed_updateds", "pug_evm_contracts"
  add_foreign_key "pug_sub_api_sub_api_feed_updateds", "pug_evm_logs"
  add_foreign_key "pug_sub_api_sub_api_feed_updateds", "pug_networks"
end
