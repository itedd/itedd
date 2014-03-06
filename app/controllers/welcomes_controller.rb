class WelcomesController < ApplicationController
  include IcalConcern

  skip_before_filter :authenticate_user!

  respond_to :ics, only: :show

  def show
    @events = Event.upcoming_events
    respond_to do |format|
      format.html
      format.ics do
        render text: events_ical(@events)
      end
    end
  end

  def index
    @organizers = Organizer.all
  end

end
