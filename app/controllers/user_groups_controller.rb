class UserGroupsController < ApplicationController
  load_and_authorize_resource

  def edit
  end

  def update
    if @user_group.update(user_params)
      flash[:notice] = 'Die Änderungen wurden gespeichert.'
      redirect_to edit_user_group_path(@user_group)
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