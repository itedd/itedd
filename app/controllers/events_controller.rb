class EventsController < ApplicationController
  include IcalConcern

  before_filter :load_deleted_event, only: :restore
  load_and_authorize_resource only: [:create, :new, :edit, :update, :destroy, :restore]
  skip_before_filter :authenticate_user!, only: [:index]
  respond_to :json, only: :index
  respond_to :ics, only: :index

  def new
  end

  def create
    if @event.update(event_params)
      flash[:notice] = 'Die Änderungen wurden gespeichert.'
      redirect_to edit_event_path(@event)
    else
      render 'new'
    end
  end

  def edit
  end

  def destroy
    @event.destroy
    flash[:notice] = 'Event wurde gesperrt.'
    redirect_to request.referer || root_path
  end

  def restore
    @event.restore
    flash[:notice] = 'Event wurde wieder hergestellt.'
    redirect_to request.referer || root_path
  end

  def update
    if @event.update(event_params)
      flash[:notice] = 'Die Änderungen wurden gespeichert.'
      redirect_to edit_event_path(@event)
    else
      render 'edit'
    end
  end

  def index
    @events = Event.upcoming.approved.for_user_group(params[:user_group_id])
    @events = @events.limit(params[:limit]) if params[:limit]
    respond_to do |format|
      format.json { render json: events_to_json }
      format.ics  { render text: events_ical(@events) }
    end
  end

  private

  def load_deleted_event
    @event = Event.with_deleted.find(params[:id])
  end

  def event_params
    if current_user.admin?
      params.require(:event).permit(:id, :text, :link, :happens_at, :user_group_id)
    else
      p = params.require(:event).permit(:id, :text, :link, :happens_at)
      p[:user_group_id] = current_user.user_group_id
      p
    end
  end

  def events_to_json
    @events.collect do |event|
      {
          date: "#{event.happens_at.to_time.to_i*1000}",
          type: 'meeting',
          title: event.user_group.name,
          description: event.text,
          url: event.link
      }
    end
  end
end
