class UserGroupAdminsController < ApplicationController
  def index
    authorize! :manage, UserGroup
    @user_groups = UserGroup.accessible_by(current_ability, :manage)
    if @user_groups.size==1
      redirect_to controller: :user_groups, action: :show, id: @user_groups.first.id
    end
  end

  def edit
    @user_group = UserGroup.find(params[:id])
    authorize! :manage, @user_group
  end

  def update
    @user_group = UserGroup.find(params[:id])
    authorize! :manage, @user_group
    if @user_group.update_attributes(user_group_params)
      redirect_to :user_group_admins
    else
      render :edit
    end
  end

  private

  def user_group_params
    params.require(:user_group).permit(:name, :color, :logo, :website, :description, :facebook_page, :googleplus_page, :twitter_account)
  end
end

