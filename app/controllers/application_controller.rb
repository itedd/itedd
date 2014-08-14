class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if current_user.admin?
      user_admins_path
    elsif current_user.user_group.present?
      user_group_path(current_user.user_group)
    else
      root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :user_group_id, user_group_attributes:[:name, :color, :logo, :website, :description, :facebook_page, :googleplus_page, :twitter_account])
    end
  end
end
