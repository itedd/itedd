class WelcomesController < ApplicationController

  skip_before_filter :authenticate_user!


  def faq
  end

  def impressum
  end

  def show
    @events = Event.upcoming.approved

    respond_to do |format|
      format.html do
        @events_per_day = Event.per_day(@events)
      end
    end
  end
end
