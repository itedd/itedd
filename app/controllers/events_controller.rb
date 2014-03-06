class EventsController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :persist_params

  def show
    page = session[:page]
    per = session[:per]

    if page>=0
      @events = Event.upcoming_events.for_organizer(session[:filter_org]).limit(per).offset(page*per)
    else
      @events = Event.finished_events.for_organizer(session[:filter_org]).limit(per).offset((-page-1)*per)
      @events.reverse!
    end

    render 'show', layout: 'embed'
  end

  private

  def persist_params
    session[:page] ||= 0
    session[:per]  ||= 10

    session[:page]       = params[:page].to_i  if params.has_key? :page
    session[:per]        = params[:per].to_i   if params.has_key? :per
    session[:filter_org] = params[:filter_org] if params.has_key? :filter_org
  end
end