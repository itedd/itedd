class EmbeddedController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:embedded, :index]

  def index

  end

  def embedded
    @page = params[:page].to_i
    @per = (params[:per] || 10).to_i

    if params[:user_group_id].present? && params[:user_group_id].to_s!='0'
      @user_groups = UserGroup.approved.where('user_groups.id=?', params[:user_group_id])
    else
      @user_groups = UserGroup.approved
    end

    if @page>=0
      @events = Event.upcoming_events.for_user_groups(@user_groups).limit(@per).offset(@page*@per)
    else
      @events = Event.finished_events.for_user_groups(@user_groups).limit(@per).offset((-1*@page-1)*@per)
      @events.reverse!
    end

    @per_day = Event.per_day(@events)

    render 'show', layout: 'embed'
  end

end
