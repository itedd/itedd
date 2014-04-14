class EmbeddedController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:index, :show, :calendar]

  def index
    render layout: 'application'
  end

  def show
    @events = Event.for_user_group(user_group_id).page(page, per_page)
    @per_day = Event.per_day(@events)
  end

  def calendar
  end

  private

  def page
    params[:page].to_i
  end

  def per_page
    desire = (params[:per] || 10).to_i
    1 if desire < 1
    100 if desire > 100
    desire
  end

  def user_group_id
    params[:user_group_id]
  end
  helper_method :page, :per_page, :user_group_id
end
