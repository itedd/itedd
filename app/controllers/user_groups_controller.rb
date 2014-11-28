class UserGroupsController < ApplicationController
  load_and_authorize_resource
  skip_before_filter :authenticate_user!, only: [:show, :index]

  def index
    if can? :manage, UserGroup
      @user_groups = UserGroup.all
    else
      @user_groups = UserGroup.approved
    end
  end

  def show
    @events = if can?(:manage, @user_group)
      Event.with_deleted.upcoming.for_user_group(@user_group)
    else
      Event.upcoming.for_user_group(@user_group)
    end
  end

  def edit
  end

  def update
    if @user_group.update(user_group_params)
      flash[:notice] = 'Die Änderungen wurden gespeichert.'
      redirect_to user_group_path(@user_group)
    else
      render 'edit'
    end
  end

  private

  def user_group_params
    params.require(:user_group).permit(
        :id, :name, :twitter_account, :color, :logo, :website,
        :description, :facebook_page, :googleplus_page, :ical_url)
  end
end
