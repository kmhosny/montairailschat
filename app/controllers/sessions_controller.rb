class SessionsController < ApplicationController
  def show
  end

  def new
    user = User.find_by(email: params[:email])
    Rails.logger.info("PARAMS #{params.inspect}")
    if user&.authenticate(params[:password_digest])
      Rails.logger.info("User #{user.id} logged in")
      cookies.encrypted[:user_id] = user.id
      redirect_to user_path(user)
    else
      Rails.logger.info("Failed login attempt for #{params[:email]}")
      render :show
    end
  end
end