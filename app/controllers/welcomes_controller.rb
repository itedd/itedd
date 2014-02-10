class WelcomesController < ApplicationController
  include IcalConcern

  skip_before_filter :authenticate_user!

  respond_to :ics, only: :show

  def show
    @events = Event.upcomming_events
    respond_to do |format|
      format.html
      format.ics do
        render text: events_ical(@events)
      end
    end
  end

end
