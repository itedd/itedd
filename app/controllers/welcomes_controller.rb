class WelcomesController < ApplicationController
  include IcalConcern

  skip_before_filter :authenticate_user!

  respond_to :ics, only: :index

  def show
    @user_groups = UserGroup.approved
    @events = Event.upcoming_events.for_user_groups(@user_groups)
    @map = {}
    @days = []
    @events.each do |event|
      @days << event.happens_at
      @map[event.happens_at] ||= []
      @map[event.happens_at] << event
    end
    @days.uniq!
    respond_to do |format|
      format.html
      format.ics do
        render text: events_ical(@events)
      end
    end
  end

end
