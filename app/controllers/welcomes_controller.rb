class WelcomesController < ApplicationController

  skip_before_filter :authenticate_user!

  def show
    @events = Event.upcomming_events
  end

end
