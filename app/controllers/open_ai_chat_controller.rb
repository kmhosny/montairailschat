class OpenAiChatController < ApplicationController
  skip_forgery_protection if Proc.new { |c| c.request.format.json? }
  before_action :authenticate_request!

  def create
    message = params[:message]
    render json: { error: "Message is required" }, status: :bad_request if message.blank?
    message_received_at = Time.now

    client = OpenAI::Client.new
    response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user", content: message}], # Required.
        temperature: 0.7,
    })
    response_message = response.dig("choices", 0, "message", "content")
    ChatHistory.transaction do
      ChatHistory.create!(message: message, user: @current_user, message_type: ChatHistory.message_types[:request], created_at: message_received_at)
      ChatHistory.create!(message: response_message, user: @current_user, message_type: ChatHistory.message_types[:response])
    end
    render json: { response: response_message }, status: :created
  end
end
