class MessagesController < ApplicationController
  before_action :set_message, only: %i[show]

  # GET /messages or /messages.json
  def index
    @messages = Message.order(block_timestamp: :desc)
  end

  # GET /messages/1 or /messages/1.json
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message =
      if params[:id].present?
        Message.find(params[:id])
      else
        network = Pug::Network.find_by(name: params[:network])
        Message.find_by(from_network: network, index: params[:index])
      end

    return unless @message.nil?

    # 404
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404.html", status: :not_found }
      format.json { render json: { error: 'Not Found' }, status: :not_found }
    end
  end
end
