require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @message = messages(:one)
  end

  test "should get index" do
    get messages_url
    assert_response :success
  end

  test "should get new" do
    get new_message_url
    assert_response :success
  end

  test "should create message" do
    assert_difference("Message.count") do
      post messages_url, params: { message: { block_number: @message.block_number, block_timestamp: @message.block_timestamp, channel: @message.channel, clear_block_number: @message.clear_block_number, clear_block_timestamp: @message.clear_block_timestamp, clear_transaction_hash: @message.clear_transaction_hash, dispatch_block_number: @message.dispatch_block_number, dispatch_block_timestamp: @message.dispatch_block_timestamp, dispatch_transaction_hash: @message.dispatch_transaction_hash, encoded: @message.encoded, from: @message.from, from_chain_id: @message.from_chain_id, from_network_id: @message.from_network_id, index: @message.index, msg_hash: @message.msg_hash, root: @message.root, status: @message.status, to: @message.to, to_chain_id: @message.to_chain_id, to_network_id: @message.to_network_id, transaction_hash: @message.transaction_hash } }
    end

    assert_redirected_to message_url(Message.last)
  end

  test "should show message" do
    get message_url(@message)
    assert_response :success
  end

  test "should get edit" do
    get edit_message_url(@message)
    assert_response :success
  end

  test "should update message" do
    patch message_url(@message), params: { message: { block_number: @message.block_number, block_timestamp: @message.block_timestamp, channel: @message.channel, clear_block_number: @message.clear_block_number, clear_block_timestamp: @message.clear_block_timestamp, clear_transaction_hash: @message.clear_transaction_hash, dispatch_block_number: @message.dispatch_block_number, dispatch_block_timestamp: @message.dispatch_block_timestamp, dispatch_transaction_hash: @message.dispatch_transaction_hash, encoded: @message.encoded, from: @message.from, from_chain_id: @message.from_chain_id, from_network_id: @message.from_network_id, index: @message.index, msg_hash: @message.msg_hash, root: @message.root, status: @message.status, to: @message.to, to_chain_id: @message.to_chain_id, to_network_id: @message.to_network_id, transaction_hash: @message.transaction_hash } }
    assert_redirected_to message_url(@message)
  end

  test "should destroy message" do
    assert_difference("Message.count", -1) do
      delete message_url(@message)
    end

    assert_redirected_to messages_url
  end
end
