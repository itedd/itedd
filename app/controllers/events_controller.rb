class EventsController < ApplicationController
  skip_before_filter :authenticate_user!

  def show
    @page = params[:page].to_i
    @per = (params[:per] || 10).to_i
    if not params[:organizer_ids].blank?
      @organizers = Organizer.find(params[:organizer_ids])
    elsif not params[:organizer_id].blank?
      @organizers = Organizer.where('id=?', params[:organizer_id])
    end
    if @page>=0
      @events = Event.upcoming_events.for_organizers(@organizers).limit(@per).offset(@page*@per)
    else
      @events = Event.finished_events.for_organizers(@organizers).limit(@per).offset((-1*@page-1)*@per)
      @events.reverse!
    end

    render 'show', layout: 'embed'
  end

end