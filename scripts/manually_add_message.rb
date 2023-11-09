def test
  event = Pug::OrmpMessageAccepted.first
  network = event.network
  Message.create!(
    msg_hash: event.msg_hash,
    root: event.root,
    channel: event.message_channel,
    index: event.message_index,
    from_chain_id: event.message_from_chain_id,
    from: event.message_from,
    to_chain_id: event.message_to_chain_id,
    to: event.message_to,
    encoded: event.message_encoded,
    block_number: event.evm_log.block_number,
    block_timestamp: event.evm_log.timestamp,
    transaction_hash: event.evm_log.transaction_hash,
    status: :accepted,
    from_network: network,
    to_network: Pug::Network.find_by_chain_id(event.message_to_chain_id)
  )
end
