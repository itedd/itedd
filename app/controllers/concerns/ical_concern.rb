module IcalConcern
  include ActiveSupport::Concern

  def events_ical(events)
    RiCal.Calendar do
      events.each do |ev|
        event do
          description ev.text
          summary     ev.user_group.name
          dtstart     ev.happens_at
          dtend       ev.happens_at+2.hours
          url         ev.link
        end
      end
    end
  end
end
