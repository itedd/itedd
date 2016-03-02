require 'http'

class MeetupReader < BaseReader
  class << self
    def cronjob
      UserGroup.with_meetup.each do |account|
        new(account).run
      end
    end
  end

  def initialize user_group
    @user_group = user_group
  end

  def user_group
    @user_group
  end

  def group_name
    group_url = user_group.meetup_url
    group_url = group_url[0..-2] if group_url[-1] == '/'
    group_url.split('/')[-1]
  end

  def api_url
    "https://api.meetup.com/#{group_name}/events?page=2"
  end

  def run
    events = get api_url
    return unless events.present?

    events.each do |event|
      handle_event event
    end
  end

  def get url
    HTTP.get url
  end

  def handle_event json_event
    link = json_event['link']
    event = user_group.events.where(link: link).first_or_initialize
    event.text = json_event['name']
    event.happens_at = datetime_of(json_event, 'time')
    event.save
  end

  def datetime_of(json_event, field)
    offset = Rational(json_event['utc_offset'], 24 * 60 * 60 * 1000) # hours * minutes * seconds * milliseconds
    Time.at(json_event[field] / 1000).to_datetime.new_offset(offset)
  end
end