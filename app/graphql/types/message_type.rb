# frozen_string_literal: true

module Types
  class MessageType < Types::BaseObject
    field :id, ID, null: false
    field :index, Integer
    field :msg_hash, String
    field :root, String
    field :channel, String
    field :from_chain_id, Integer
    field :from, String
    field :to_chain_id, Integer
    field :to, String
    field :block_number, Integer
    field :block_timestamp, Integer
    field :transaction_hash, String
    field :status, Integer
    field :encoded, String
    field :from_network_id, Integer
    field :to_network_id, Integer
    field :dispatch_transaction_hash, String
    field :dispatch_block_number, Integer
    field :dispatch_block_timestamp, Integer
    field :clear_transaction_hash, String
    field :clear_block_number, Integer
    field :clear_block_timestamp, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :proof, GraphQL::Types::JSON
    field :msgport_payload, String
    field :msgport_from, String
    field :msgport_to, String
    field :gas_limit, Integer
  end
end
