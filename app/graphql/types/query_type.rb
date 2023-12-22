# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: 'Fetches an object given its ID.' do
      argument :id, ID, required: true, description: 'ID of the object.'
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, { null: true }], null: true,
                                                     description: 'Fetches a list of objects given a list of IDs.' do
      argument :ids, [ID], required: true, description: 'IDs of the objects.'
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :message, Types::MessageType, null: true do
      argument :msg_hash, ID, required: true
    end
    def message(msg_hash:)
      Message.find_by(msg_hash:)
    end

    field :messages, [Types::MessageType], null: true
    def messages
      Message.all
    end

    field :ormp_message_accepteds, [Types::Pug::OrmpMessageAcceptedType], null: true do
      argument :message_from_chain_id, Float, required: false
      argument :message_to_chain_id, Float, required: false
    end
    def ormp_message_accepteds(message_from_chain_id: nil, message_to_chain_id: nil)
      where = {}
      where[:message_from_chain_id] = message_from_chain_id if message_from_chain_id.present?
      where[:message_to_chain_id] = message_to_chain_id if message_to_chain_id.present?
      ::Pug::OrmpMessageAccepted.where(where)
    end
  end
end
