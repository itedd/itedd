class UserGroupsController < ApplicationController
  def edit
    @user_group = UserGroup.find_by_user_id current_user
  end

  def update
    @user_group = UserGroup.find_by_user_id current_user
    if @user_group.update(user_params)
      flash[:notice] = "Die Änderungen wurden gespeichert."
      redirect_to edit_user_groups_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user_group).permit(
        :name, :twitter_account, :color, :logo, :website,
        :description, :facebook_page, :googleplus_page)
  end
end