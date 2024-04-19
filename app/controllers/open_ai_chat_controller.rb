class OpenAiChatController < ApplicationController
  def create
    message = params[:message]
    render json: { error: "Message is required" }, status: :bad_request if message.blank?

    client = OpenAI::Client.new
    response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user", content: "Hello!"}], # Required.
        temperature: 0.7,
    })

    render json: { response: response.dig("choices", 0, "message", "content") }
  end
end
