module IcalConcern
  include ActiveSupport::Concern

  def events_ical(events)
    RiCal.Calendar do |cal|
      events.each do |event|
        cal.event do |item|
          item.summary     = event.link
          item.description = event.text
          item.dtstamp     = event.happens_at
          #item.dtend       = event.end_date
          #item.location    = event.location.name
          item.url         = event.link
        end
      end
    end
  end
end
