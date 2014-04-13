class UserGroupAdminsController < ApplicationController
  before_filter :load_and_authorize_user_group

  def index
    if @user_groups.size==1
      redirect_to controller: :user_groups, action: :show, id: @user_groups.first.id
    end
  end

  def edit
  end

  def update
    if @user_group.update_attributes(user_group_params)
      redirect_to :user_group_admins
    else
      render :edit
    end
  end

  private

  def load_and_authorize_user_group
    old_action = params[:action]
    params[:action] = :manage
    self.class.cancan_resource_class.new(self, nil, class: 'UserGroup', instance_name: :user_group).load_and_authorize_resource
  ensure
    params[:action] = old_action
  end

  def user_group_params
    params.require(:user_group).permit(:name, :color, :logo, :website, :description, :facebook_page, :googleplus_page, :twitter_account)
  end
end
