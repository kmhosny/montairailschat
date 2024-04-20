class ApplicationController < ActionController::Base
  def authenticate_request!
    header = request.headers['Authorization']
    header = header&.split(' ').last if header
    begin
      @decoded = decode(header)
      user_id = if @decoded
        @decoded[:user_id]
      else
        cookies.encrypted[:user_id]
      end
      @current_user = User.find(user_id)
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  private

  def decode(token)
    body = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
    HashWithIndifferentAccess.new body
  rescue
    nil
  end
end
