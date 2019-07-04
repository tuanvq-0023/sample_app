class SessionsController < ApplicationController
  def new; end

  def create
    user = get_user
    rmb_set = Settings.remember_checked_default_value

    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == rmb_set ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = t ".invalid_user_info"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def get_user
    User.find_by email: params[:session][:email].downcase
  end
end
