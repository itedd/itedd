class UserGroupsController < ApplicationController
  load_and_authorize_resource
  skip_before_filter :authenticate_user!, only: :show

  def show
    @user_group = UserGroup.find(params[:id])

    if can?(:manage, @user_group)
      @events = Event.with_deleted.upcoming_events.for_user_group(@user_group)
    else
      @events = Event.upcoming_events.for_user_group(@user_group)
    end
  end

  def edit
  end

  def update
    if @user_group.update(user_params)
      flash[:notice] = 'Die Änderungen wurden gespeichert.'
      redirect_to user_group_path(@user_group)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user_group).permit(
        :id, :name, :twitter_account, :color, :logo, :website,
        :description, :facebook_page, :googleplus_page)
  end
end