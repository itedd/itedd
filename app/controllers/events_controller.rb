class EventsController < ApplicationController
  skip_before_filter :authenticate_user!

  def show
    @page = params[:page].to_i
    @per = (params[:per] || 10).to_i
    if not params[:user_group_ids].blank?
      @user_groups = UserGroup.find(params[:user_group_ids])
    elsif not params[:user_group_id].blank?
      @user_groups = UserGroup.where('id=?', params[:user_group_id])
    end
    if @page>=0
      @events = Event.upcoming_events.for_user_groups(@user_groups).limit(@per).offset(@page*@per)
    else
      @events = Event.finished_events.for_user_groups(@user_groups).limit(@per).offset((-1*@page-1)*@per)
      @events.reverse!
    end

    render 'show', layout: 'embed'
  end

end