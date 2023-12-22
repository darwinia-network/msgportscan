# frozen_string_literal: true

module Types
  class Pug::OrmpMessageAcceptedType < Types::BaseObject
    field :id, ID, null: false
    field :pug_evm_log_id, Integer, null: false
    field :pug_evm_contract_id, Integer, null: false
    field :pug_network_id, Integer, null: false
    field :msg_hash, String
    field :root, String
    field :message_channel, String
    field :message_index, Float
    field :message_from_chain_id, Float
    field :message_from, String
    field :message_to_chain_id, Float
    field :message_to, String
    field :message_gas_limit, Float
    field :message_encoded, String
    field :timestamp, GraphQL::Types::ISO8601DateTime
    field :block_number, Integer
    field :transaction_index, Integer
    field :log_index, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
