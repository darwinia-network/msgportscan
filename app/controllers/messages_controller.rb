class MessagesController < ApplicationController
  before_action :set_message, only: %i[show]
  before_action -> { @messages_count = Message.count }, only: %i[index show]

  # GET /messages or /messages.json
  def index
    from_network = Pug::Network.find_by(name: params[:from_network]) if params[:from_network].present?
    to_network = Pug::Network.find_by(name: params[:to_network]) if params[:to_network].present?

    @messages = Message.includes(:from_network, :to_network, :from_contract, :to_contract)
    @messages = @messages.where(from_network:) if from_network.present?
    @messages = @messages.where(to_network:) if to_network.present?
    @messages = @messages.where(status: params[:status]) if params[:status].present?
    @messages = @messages.order(block_timestamp: :desc).page(params[:page]).per(25)
  end

  # GET /messages/1 or /messages/1.json
  def show; end

  def message
    if params[:tx_or_hash].start_with?('0x')
      # query from form
      redirect_to message_by_tx_or_hash_path(params[:tx_or_hash])
    else
      redirect_to messages_path
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message =
      if params[:id].present?
        Message.find(params[:id])
      elsif params[:from_network] && params[:to_network] && params[:index]
        from_network = Pug::Network.find_by(name: params[:from_network])
        to_network = Pug::Network.find_by(name: params[:to_network])
        Message.find_by(from_network:, to_network:, index: params[:index])
      elsif params[:tx_or_hash].present?
        Message.find_by(transaction_hash: params[:tx_or_hash]) || Message.find_by(msg_hash: params[:tx_or_hash])
      end

    return unless @message.nil?

    # 404
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404.html" }
      format.json { render json: { error: 'Not Found' }, status: :not_found }
    end
  end
end
