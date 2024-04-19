class OpenAiChatController < ApplicationController
  def create
    message = params[:message]
    render json: { error: "Message is required" }, status: :bad_request if message.blank?
    Rails.logger.info("Message received: #{message}")
  end
end
