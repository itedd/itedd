class EventsController < ApplicationController
  skip_before_filter :authenticate_user!, only: :embedded
  load_and_authorize_resource
  skip_authorize_resource :only => :embedded

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:notice] = 'Die Änderungen wurden gespeichert.'
      redirect_to edit_event_path(@event)
    else
      render 'edit'
    end
  end

  def embedded
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

  private

  def event_params
    params.require(:event).permit(:id, :text, :link, :happens_at)
  end

end
