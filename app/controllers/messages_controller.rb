class MessagesController < ApplicationController
  before_action :set_message, only: %i[show]

  # GET /messages or /messages.json
  def index
    from_network = Pug::Network.find_by(name: params[:from_network]) if params[:from_network].present?
    to_network = Pug::Network.find_by(name: params[:to_network]) if params[:to_network].present?

    @messages = Message.all
    @messages = @messages.where(from_network:) if from_network.present?
    @messages = @messages.where(to_network:) if to_network.present?
    @messages = @messages.order(block_timestamp: :desc)
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
        from_network = Pug::Network.find_by(name: params[:from_network])
        to_network = Pug::Network.find_by(name: params[:to_network])
        Message.find_by(from_network:, to_network:, index: params[:index])
      end

    return unless @message.nil?

    # 404
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404.html", status: :not_found }
      format.json { render json: { error: 'Not Found' }, status: :not_found }
    end
  end
end
