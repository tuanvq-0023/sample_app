class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        session_remember_user user
        redirect_back_or user
      else
        flash[:warning] = t ".account_not_activated"
        redirect_to root_url
      end
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

  def session_remember_user user
    if params[:session][:remember_me] == Settings.remember_checked_default_value
      remember user
    else
      forget user
    end
  end
end
