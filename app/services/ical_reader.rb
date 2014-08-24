require 'http'

class IcalReader < BaseReader
  class << self
    def cronjob
      UserGroup.with_ical.each do |account|
        new(account).run
      end
    end
  end

  def initialize(user_group)
    @user_group = user_group

  end

  def run
    body = get(@user_group.ical_url)
    return if !body.present?

    calendar = RiCal.parse_string(body)
    events = calendar.first.subcomponents.first[1]
    events.each do |event|
      parse_event(event)
    end
  end

  def parse_event(calendar_event)
    event = Event.where(link: calendar_event.url, user_group_id: @user_group.id).first_or_initialize
    event.assign_attributes(
      text:       calendar_event.summary,
      happens_at: calendar_event.dtstart,
    )
    event.save
  end

  def get(url)
    HTTP.get url
  end

end
