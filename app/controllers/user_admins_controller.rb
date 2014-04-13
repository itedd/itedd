class UserAdminsController < ApplicationController
  before_filter :load_and_authorize_user, except: :index

  def index
    authorize! :manage, User
    @users = User.all
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to :user_admins
    else
      render :edit
    end
  end

  def set
    case params[:action_id]
      when 'permit'
        @user.approved = true
      when 'deny'
        @user.approved = false
      when 'set_admin'
        @user.admin = true
      when 'unset_admin'
        @user.admin = false
    end
    @user.save
    redirect_to :user_admins
  end

  private

  def load_and_authorize_user
    old_action = params[:action]
    params[:action] = :manage
    self.class.cancan_resource_class.new(self, nil, class: 'User', instance_name: :user).load_and_authorize_resource
  ensure
    params[:action] = old_action
  end

  def user_params
    p = params.required(:user).permit(:email, :password, :password_confirmation, :user_group_id)
    unless p[:password].present?
      p.delete :password
      p.delete :password_confirmation
    end
    p
  end
end
