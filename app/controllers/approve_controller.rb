class ApproveController < ApplicationController
  def index
    @users = User.where(approved: false)
  end

  def approve
    @user = User.find(params[:id])
    authorize! :approve, @user
    @user.approved = true
    @user.save
    redirect_to :approve
  end
end
