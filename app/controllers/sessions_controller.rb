class SessionsController < ApplicationController
  def show
  end

  def new
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      Rails.logger.info("User #{user.id} logged in")
      cookies.encrypted[:user_id] = user.id
      redirect_to user_path(user)
    else
      Rails.logger.error("Failed login attempt for #{params[:email]}")
      render :show
    end
  end

  def destroy
    cookies.delete(:user_id)
    redirect_to login_path
  end
end
