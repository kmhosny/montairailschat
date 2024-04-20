module Api
  class AuthenticationController < ::ApplicationController
    skip_forgery_protection
    rescue_from StandardError, with: :hide_500_errors

    # POST /auth/login
    def login
      user = User.find_by(email: params[:email])

      if user&.authenticate(params[:password])
        token = encode_user_data({ user_id: user.id })
        render json: { token: token }, status: :ok
      else
        render json: { error: 'Invalid credentials' }, status: :unauthorized
      end
    end

    def signup
      @user = User.new(user_params)

      respond_to do |format|
        if @user.save
          format.json {
            token = encode_user_data({ user_id: @user.id })
            render json: { token: token, user: { id: @user.id, email: @user.email } }, status: :created
          }
        else
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def encode_user_data(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.credentials.secret_key_base)
    end
    
    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password)
    end

    def hide_500_errors(exception)
      render json: { error: 'Internal Server Error', details: exception.message }, status: :internal_server_error
    end
  end
end