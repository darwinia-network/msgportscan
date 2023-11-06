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

ActiveRecord::Schema[7.1].define(version: 2023_11_06_061157) do
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
    t.text "encoded"
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
    t.string "name"
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
    t.integer "evm_transaction_id"
    t.index ["network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_network_id_block_number_transaction_index_lo_603ca303c9", unique: true
    t.index ["topic0"], name: "index_pug_evm_logs_on_topic0"
    t.index ["topic1"], name: "index_pug_evm_logs_on_topic1"
    t.index ["topic2"], name: "index_pug_evm_logs_on_topic2"
    t.index ["topic3"], name: "index_pug_evm_logs_on_topic3"
  end

  create_table "pug_evm_transactions", force: :cascade do |t|
    t.integer "evm_contract_id"
    t.integer "network_id"
    t.string "block_hash"
    t.string "block_number"
    t.string "chain_id"
    t.string "from"
    t.string "to"
    t.string "value"
    t.string "gas"
    t.string "gas_price"
    t.string "transaction_hash"
    t.text "input"
    t.string "max_priority_fee_per_gas"
    t.string "max_fee_per_gas"
    t.string "nonce"
    t.string "r"
    t.string "s"
    t.string "v"
    t.string "transaction_index"
    t.string "transaction_type"
    t.index ["network_id", "transaction_hash"], name: "index_pug_evm_transactions_on_network_id_and_transaction_hash", unique: true
  end

  create_table "pug_networks", force: :cascade do |t|
    t.bigint "chain_id"
    t.string "name"
    t.string "display_name"
    t.string "rpc"
    t.string "explorer"
    t.integer "scan_span", default: 2000
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
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_oracle_assigneds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_oracle_assigneds_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_f0df60903d", unique: true
    t.index ["pug_network_id", "fee"], name: "index_pug_oracle_assigneds_on_pug_network_id_and_fee"
    t.index ["pug_network_id", "msg_hash"], name: "index_pug_oracle_assigneds_on_pug_network_id_and_msg_hash"
    t.index ["pug_network_id"], name: "index_pug_oracle_assigneds_on_pug_network_id"
  end

  create_table "pug_oracle_set_approveds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "operator"
    t.boolean "approve"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_oracle_set_approveds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_oracle_set_approveds_on_pug_evm_log_id"
    t.index ["pug_network_id", "approve"], name: "index_pug_oracle_set_approveds_on_pug_network_id_and_approve"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_dbc1616209", unique: true
    t.index ["pug_network_id", "operator"], name: "index_pug_oracle_set_approveds_on_pug_network_id_and_operator"
    t.index ["pug_network_id"], name: "index_pug_oracle_set_approveds_on_pug_network_id"
  end

  create_table "pug_oracle_set_dapis", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.decimal "chain_id", precision: 78
    t.string "dapi"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_oracle_set_dapis_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_oracle_set_dapis_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_35647beda6", unique: true
    t.index ["pug_network_id", "chain_id"], name: "index_pug_oracle_set_dapis_on_pug_network_id_and_chain_id"
    t.index ["pug_network_id", "dapi"], name: "index_pug_oracle_set_dapis_on_pug_network_id_and_dapi"
    t.index ["pug_network_id"], name: "index_pug_oracle_set_dapis_on_pug_network_id"
  end

  create_table "pug_oracle_set_fees", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.decimal "chain_id", precision: 78
    t.decimal "fee", precision: 78
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_oracle_set_fees_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_oracle_set_fees_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_c24f05a513", unique: true
    t.index ["pug_network_id", "chain_id"], name: "index_pug_oracle_set_fees_on_pug_network_id_and_chain_id"
    t.index ["pug_network_id", "fee"], name: "index_pug_oracle_set_fees_on_pug_network_id_and_fee"
    t.index ["pug_network_id"], name: "index_pug_oracle_set_fees_on_pug_network_id"
  end

  create_table "pug_ormp_app_config_updateds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "ua"
    t.string "oracle"
    t.string "relayer"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_ormp_app_config_updateds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_ormp_app_config_updateds_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_2b01289eec", unique: true
    t.index ["pug_network_id", "oracle"], name: "idx_on_pug_network_id_oracle_d0cd39ee84"
    t.index ["pug_network_id", "relayer"], name: "idx_on_pug_network_id_relayer_69c0165f01"
    t.index ["pug_network_id", "ua"], name: "index_pug_ormp_app_config_updateds_on_pug_network_id_and_ua"
    t.index ["pug_network_id"], name: "index_pug_ormp_app_config_updateds_on_pug_network_id"
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
    t.decimal "message_gas_limit", precision: 78
    t.string "message_encoded"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_ormp_message_accepteds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_ormp_message_accepteds_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_7c0e6d0e21", unique: true
    t.index ["pug_network_id", "message_channel"], name: "idx_on_pug_network_id_message_channel_9fcbfce120"
    t.index ["pug_network_id", "message_encoded"], name: "idx_on_pug_network_id_message_encoded_a8264b4473"
    t.index ["pug_network_id", "message_from"], name: "idx_on_pug_network_id_message_from_b377f3ea44"
    t.index ["pug_network_id", "message_from_chain_id"], name: "idx_on_pug_network_id_message_from_chain_id_4a514658c0"
    t.index ["pug_network_id", "message_gas_limit"], name: "idx_on_pug_network_id_message_gas_limit_122237f108"
    t.index ["pug_network_id", "message_index"], name: "idx_on_pug_network_id_message_index_651bf9858b"
    t.index ["pug_network_id", "message_to"], name: "idx_on_pug_network_id_message_to_66672a857b"
    t.index ["pug_network_id", "message_to_chain_id"], name: "idx_on_pug_network_id_message_to_chain_id_04c24c674f"
    t.index ["pug_network_id", "msg_hash"], name: "idx_on_pug_network_id_msg_hash_512c191bd5"
    t.index ["pug_network_id", "root"], name: "index_pug_ormp_message_accepteds_on_pug_network_id_and_root"
    t.index ["pug_network_id"], name: "index_pug_ormp_message_accepteds_on_pug_network_id"
  end

  create_table "pug_ormp_message_dispatcheds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "msg_hash"
    t.boolean "dispatch_result"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_ormp_message_dispatcheds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_ormp_message_dispatcheds_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_3352e95027", unique: true
    t.index ["pug_network_id", "dispatch_result"], name: "idx_on_pug_network_id_dispatch_result_3375b9f83f"
    t.index ["pug_network_id", "msg_hash"], name: "idx_on_pug_network_id_msg_hash_33a7665886"
    t.index ["pug_network_id"], name: "index_pug_ormp_message_dispatcheds_on_pug_network_id"
  end

  create_table "pug_ormp_set_default_configs", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "oracle"
    t.string "relayer"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_ormp_set_default_configs_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_ormp_set_default_configs_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_f36d2aa15c", unique: true
    t.index ["pug_network_id", "oracle"], name: "idx_on_pug_network_id_oracle_90a88e2d35"
    t.index ["pug_network_id", "relayer"], name: "idx_on_pug_network_id_relayer_7ed99b847d"
    t.index ["pug_network_id"], name: "index_pug_ormp_set_default_configs_on_pug_network_id"
  end

  create_table "pug_relayer_assigneds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "msg_hash"
    t.decimal "fee", precision: 78
    t.string "params"
    t.string "proof"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_relayer_assigneds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_relayer_assigneds_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_2665d02ebb", unique: true
    t.index ["pug_network_id", "fee"], name: "index_pug_relayer_assigneds_on_pug_network_id_and_fee"
    t.index ["pug_network_id", "msg_hash"], name: "index_pug_relayer_assigneds_on_pug_network_id_and_msg_hash"
    t.index ["pug_network_id", "params"], name: "index_pug_relayer_assigneds_on_pug_network_id_and_params"
    t.index ["pug_network_id", "proof"], name: "index_pug_relayer_assigneds_on_pug_network_id_and_proof"
    t.index ["pug_network_id"], name: "index_pug_relayer_assigneds_on_pug_network_id"
  end

  create_table "pug_relayer_set_approveds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "operator"
    t.boolean "approve"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_relayer_set_approveds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_relayer_set_approveds_on_pug_evm_log_id"
    t.index ["pug_network_id", "approve"], name: "index_pug_relayer_set_approveds_on_pug_network_id_and_approve"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_4fe6ff52a8", unique: true
    t.index ["pug_network_id", "operator"], name: "index_pug_relayer_set_approveds_on_pug_network_id_and_operator"
    t.index ["pug_network_id"], name: "index_pug_relayer_set_approveds_on_pug_network_id"
  end

  create_table "pug_relayer_set_dst_configs", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.decimal "chain_id", precision: 78
    t.decimal "base_gas", precision: 20
    t.decimal "gas_per_byte", precision: 20
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_relayer_set_dst_configs_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_relayer_set_dst_configs_on_pug_evm_log_id"
    t.index ["pug_network_id", "base_gas"], name: "idx_on_pug_network_id_base_gas_52c49b6471"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_a7731c62b7", unique: true
    t.index ["pug_network_id", "chain_id"], name: "idx_on_pug_network_id_chain_id_ace1d171ad"
    t.index ["pug_network_id", "gas_per_byte"], name: "idx_on_pug_network_id_gas_per_byte_3e4f2801ea"
    t.index ["pug_network_id"], name: "index_pug_relayer_set_dst_configs_on_pug_network_id"
  end

  create_table "pug_relayer_set_dst_prices", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.decimal "chain_id", precision: 78
    t.decimal "dst_price_ratio", precision: 39
    t.decimal "dst_gas_price_in_wei", precision: 39
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_relayer_set_dst_prices_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_relayer_set_dst_prices_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_a19fe34800", unique: true
    t.index ["pug_network_id", "chain_id"], name: "idx_on_pug_network_id_chain_id_5a6e123ca8"
    t.index ["pug_network_id", "dst_gas_price_in_wei"], name: "idx_on_pug_network_id_dst_gas_price_in_wei_28778f22ca"
    t.index ["pug_network_id", "dst_price_ratio"], name: "idx_on_pug_network_id_dst_price_ratio_4f913548c5"
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
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_sub_api_add_beacons_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_add_beacons_on_pug_evm_log_id"
    t.index ["pug_network_id", "beacon_airnode"], name: "idx_on_pug_network_id_beacon_airnode_9eff25ae23"
    t.index ["pug_network_id", "beacon_endpoint_id"], name: "idx_on_pug_network_id_beacon_endpoint_id_2a342930f4"
    t.index ["pug_network_id", "beacon_id"], name: "index_pug_sub_api_add_beacons_on_pug_network_id_and_beacon_id"
    t.index ["pug_network_id", "beacon_sponsor"], name: "idx_on_pug_network_id_beacon_sponsor_87fcc2c491"
    t.index ["pug_network_id", "beacon_sponsor_wallet"], name: "idx_on_pug_network_id_beacon_sponsor_wallet_6b766d585b"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_bb9a992bdd", unique: true
    t.index ["pug_network_id"], name: "index_pug_sub_api_add_beacons_on_pug_network_id"
  end

  create_table "pug_sub_api_aggregated_ormp_data", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.decimal "ormp_data_count", precision: 78
    t.string "ormp_data_root"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_sub_api_aggregated_ormp_data_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_aggregated_ormp_data_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_91466b93ef", unique: true
    t.index ["pug_network_id", "ormp_data_count"], name: "idx_on_pug_network_id_ormp_data_count_2552497b33"
    t.index ["pug_network_id", "ormp_data_root"], name: "idx_on_pug_network_id_ormp_data_root_997f2b58ab"
    t.index ["pug_network_id"], name: "index_pug_sub_api_aggregated_ormp_data_on_pug_network_id"
  end

  create_table "pug_sub_api_airnode_rrp_completeds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "beacon_id"
    t.string "request_id"
    t.string "data"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "idx_on_pug_evm_contract_id_7d68e35ef3"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_airnode_rrp_completeds_on_pug_evm_log_id"
    t.index ["pug_network_id", "beacon_id"], name: "idx_on_pug_network_id_beacon_id_3af508e00e"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_8cc4699a17", unique: true
    t.index ["pug_network_id", "data"], name: "idx_on_pug_network_id_data_07f25ec1ea"
    t.index ["pug_network_id", "request_id"], name: "idx_on_pug_network_id_request_id_350af8cbfe"
    t.index ["pug_network_id"], name: "index_pug_sub_api_airnode_rrp_completeds_on_pug_network_id"
  end

  create_table "pug_sub_api_airnode_rrp_requesteds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "beacon_id"
    t.string "request_id"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "idx_on_pug_evm_contract_id_7f90448c42"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_airnode_rrp_requesteds_on_pug_evm_log_id"
    t.index ["pug_network_id", "beacon_id"], name: "idx_on_pug_network_id_beacon_id_afbb7dfa75"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_6ae83b5263", unique: true
    t.index ["pug_network_id", "request_id"], name: "idx_on_pug_network_id_request_id_b4fa0a9353"
    t.index ["pug_network_id"], name: "index_pug_sub_api_airnode_rrp_requesteds_on_pug_network_id"
  end

  create_table "pug_sub_api_ownership_transfer_starteds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "previous_owner"
    t.string "new_owner"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "idx_on_pug_evm_contract_id_07fc2e2c5b"
    t.index ["pug_evm_log_id"], name: "idx_on_pug_evm_log_id_4fb906a4ae"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_5c63a52083", unique: true
    t.index ["pug_network_id", "new_owner"], name: "idx_on_pug_network_id_new_owner_a4736a1a27"
    t.index ["pug_network_id", "previous_owner"], name: "idx_on_pug_network_id_previous_owner_21f668496e"
    t.index ["pug_network_id"], name: "idx_on_pug_network_id_e9d99d14c5"
  end

  create_table "pug_sub_api_ownership_transferreds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "previous_owner"
    t.string "new_owner"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "idx_on_pug_evm_contract_id_53307178ad"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_ownership_transferreds_on_pug_evm_log_id"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_82f0facafc", unique: true
    t.index ["pug_network_id", "new_owner"], name: "idx_on_pug_network_id_new_owner_f54621dd05"
    t.index ["pug_network_id", "previous_owner"], name: "idx_on_pug_network_id_previous_owner_47c67ee6d7"
    t.index ["pug_network_id"], name: "index_pug_sub_api_ownership_transferreds_on_pug_network_id"
  end

  create_table "pug_sub_api_remove_beacons", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "beacon_id"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_sub_api_remove_beacons_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_remove_beacons_on_pug_evm_log_id"
    t.index ["pug_network_id", "beacon_id"], name: "idx_on_pug_network_id_beacon_id_b89c25191a"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_5c5b820281", unique: true
    t.index ["pug_network_id"], name: "index_pug_sub_api_remove_beacons_on_pug_network_id"
  end

  create_table "pug_sub_api_sub_api_feed_updateds", force: :cascade do |t|
    t.bigint "pug_evm_log_id", null: false
    t.bigint "pug_evm_contract_id", null: false
    t.bigint "pug_network_id", null: false
    t.string "beacon_id"
    t.decimal "msg_root_count", precision: 78
    t.string "msg_root_root"
    t.datetime "timestamp"
    t.integer "block_number"
    t.integer "transaction_index"
    t.integer "log_index"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pug_evm_contract_id"], name: "index_pug_sub_api_sub_api_feed_updateds_on_pug_evm_contract_id"
    t.index ["pug_evm_log_id"], name: "index_pug_sub_api_sub_api_feed_updateds_on_pug_evm_log_id"
    t.index ["pug_network_id", "beacon_id"], name: "idx_on_pug_network_id_beacon_id_3da4d1e9ed"
    t.index ["pug_network_id", "block_number", "transaction_index", "log_index"], name: "idx_on_pug_network_id_block_number_transaction_inde_c9ce9155f7", unique: true
    t.index ["pug_network_id", "msg_root_count"], name: "idx_on_pug_network_id_msg_root_count_c1de86f6b6"
    t.index ["pug_network_id", "msg_root_root"], name: "idx_on_pug_network_id_msg_root_root_52014b84a5"
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
  add_foreign_key "pug_ormp_message_accepteds", "pug_evm_contracts"
  add_foreign_key "pug_ormp_message_accepteds", "pug_evm_logs"
  add_foreign_key "pug_ormp_message_accepteds", "pug_networks"
  add_foreign_key "pug_ormp_message_dispatcheds", "pug_evm_contracts"
  add_foreign_key "pug_ormp_message_dispatcheds", "pug_evm_logs"
  add_foreign_key "pug_ormp_message_dispatcheds", "pug_networks"
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
