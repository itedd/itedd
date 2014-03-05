class OrganizersController < ApplicationController
  skip_before_filter :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "Die Änderungen wurden gespeichert."
      sign_in(@user, :bypass => true)
      redirect_to edit_organizers_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    p = params.require(:organizer).permit(
        :email, :username, :twitter_account, :color, :logo, :website,
        :description, :facebook_page, :googleplus_page,
        :current_password, :password, :password_confirmation)

    if p[:current_password].blank?
      p.delete :password
      p.delete :password_confirmation
    end
    p.delete :current_password

    p
  end
end