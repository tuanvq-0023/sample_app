class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new show create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)
  before_action :load_user, except: %i(index new create)

  def index
    @users = User.page params[:page]
  end

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t ".welcome_to_the_sample_app"
      redirect_to @user
    else
      render :new
    end
  end

  def update
    if @user.update user_params
      flash[:success] = t ".profile_updated"
      redirect_to @user
    else
      flash.now[:error] = t ".profile_update_failed"
      render :edit
    end
  end

  def edit; end

  def destroy
    if @user.destroy
      flash[:success] = t ".deleted_user"
    else
      flash[:error] = t ".deleted_failed"
    end
    redirect_to users_url
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".user_not_found"
    redirect_to root_url
  end

  def user_params
    params.require(:user).permit %i(name email password password_confirmation)
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = t ".please_log_in."
    redirect_to login_url
  end

  def correct_user
    @user = User.find_by id: params[:id]
    return if current_user? @user
    flash[:danger] = t ".user_not_match"
    redirect_to root_url
  end

  def admin_user
    return if current_user.admin?
    flash[:danger] = t ".permission_denied"
    redirect_to root_url
  end
end
