class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]

    current_user.follow(@user) if @user
    respond_to do |format|
      format.html{redirect_to @user}

      if @user.nil?
        format.js{flash.now[:danger] = t(".user_not_found")}
      else
        format.js{flash.now[:message] = "#{t('.followed')} #{@user.name}"}
      end
    end
  end

  def destroy
    relationship = Relationship.find_by id: params[:id]

    if relationship
      @user = relationship.followed
      current_user.unfollow(@user)
    end
    respond_to do |format|
      format.html{redirect_to @user}
      if relationship.nil?
        format.js{flash.now[:danger] = t(".user_not_found")}
      else
        format.js{flash.now[:message] = "#{t('.unfollow')} #{@user.name}"}
      end
    end
  end
end
