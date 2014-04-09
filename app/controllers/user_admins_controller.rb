class UserAdminsController < ApplicationController
  def index
    authorize! :manage, User
    @users = User.all
  end

  def edit
    authorize! :manage, User
    @user = User.find(params[:id])
  end

  def update
    authorize! :manage, User
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to :user_admins
    else
      render :edit
    end
  end

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

  private

  def user_params
    p = params.required(:user).permit(:email, :password, :password_confirmation, :user_group_id)
    unless p[:password].present?
      p.delete :password
      p.delete :password_confirmation
    end

    p
  end
end
