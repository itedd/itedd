class ApproveController < ApplicationController
  def index
    authorize! :manage, User
    @users = User.all
  end

  def approve
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
    redirect_to :approve
  end
end
