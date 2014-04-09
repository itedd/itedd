class EventsController < ApplicationController
  load_and_authorize_resource

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


  private

  def event_params
    params.require(:event).permit(:id, :text, :link, :happens_at)
  end

end
