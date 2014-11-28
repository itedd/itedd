class BaseReader
  include ExtractDate

  def build_event(event_text, user_group, tweet_url=nil, tweet_time=Time.now)
    raise ArgumentError.new('No user_group given') unless user_group.present?

    if is_valid_text?(event_text)
      Event.new( {
        text: event_text,
        happens_at: extract_date(event_text, tweet_time),
        link: tweet_url,
        user_group: user_group,
        created_at: tweet_time
      })
    end
  end

  protected

  def is_valid_text?(event_text)
    event_text =~ /(^|\s)#event([\s:\.\(\[\{!]|$)/i
  end
end
