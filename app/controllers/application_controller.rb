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
    rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
      respond_to do |format|
        format.json { render json: { errors: e.message }, status: :unauthorized }
        format.html { redirect_to login_path, notice: 'Unauthorized Action' }
      end
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
