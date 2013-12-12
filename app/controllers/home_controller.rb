class HomeController < ApplicationController

  def index
    @events = Event.upcomming_events
  end

end
