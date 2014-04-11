class WelcomesController < ApplicationController
  include IcalConcern

  skip_before_filter :authenticate_user!

  respond_to :ics, only: :index

  def faq
  end

  def impressum
  end

  def show
    @events = Event.upcoming_events.approved

    respond_to do |format|
      format.html do
        @events_per_day = Event.per_day(@events)
      end
      format.ics do
        render text: events_ical(@events)
      end
    end
  end

end
