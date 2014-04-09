class UserGroupAdminsController < ApplicationController
  def index
    authorize! :manage, UserGroup
    @user_groups = UserGroup.all
  end

  def edit
    authorize! :manage, UserGroup
    @user_group = UserGroup.find(params[:id])
  end

  def update
    authorize! :manage, UserGroup
    @user_group = UserGroup.find(params[:id])
    if @user_group.update_attributes(user_group_params)
      redirect_to :user_group_admins
    else
      render :edit
    end
  end

=begin
  def set
    @user = User.find(params[:id])
    if current_user==@user
      raise CanCan::AccessDenied.new('Du kannst dich nicht selbst administrieren.', :manage, User)
    end
    action = params[:action_id].to_sym
    authorize! action, @user
    case action
      when :permit then
        @user.approved = true
      when :deny then
        @user.approved = false
      when :set_admin
        @user.admin = true
      when :unset_admin
        @user.admin = false
    end
    @user.save
    redirect_to :user_admins
  end
=end

  private

  def user_group_params
    params.require(:user_group).permit(:name, :color, :logo, :website, :description, :facebook_page, :googleplus_page, :twitter_account)
  end
end

