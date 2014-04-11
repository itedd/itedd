class EventsController < ApplicationController
  load_and_authorize_resource only: [:edit, :update, :destroy]
  skip_before_filter :authenticate_user!, only: [:index]
  respond_to :json, only: :index

  def edit
  end

  def destroy
    @event.destroy
    flash[:notice] = 'Event wurde gesperrt.'
    redirect_to request.referer
  end

  def restore
    @event = Event.with_deleted.find(params[:id])
    authorize! :manage, @event
    @event.restore
    flash[:notice] = 'Event wurde wieder hergestellt.'
    redirect_to request.referer
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
    @events = Event.approved.limit(params[:limit])

    json = @events.collect do |event|
      {
          date: "#{event.happens_at.to_time.to_i*1000}",
          type: 'meeting',
          title: event.user_group.name,
          description: event.text,
          url: event.link
      }
    end

    respond_to do |format|
      format.json do
        render json: json
      end
    end
  end

  private

  def event_params
    params.require(:event).permit(:id, :text, :link, :happens_at)
  end

end
