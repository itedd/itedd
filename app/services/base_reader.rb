class BaseReader

  include ExtractDate
  include ExtractLink


  def createEvent(event_text, user)
    raise ArgumentError.new("No user given") unless user.is_a?(User)

    if is_valid_text?(event_text)
      attributes = build_attributes(event_text, user)
      result = Event.new(attributes)
    else
      result = nil
    end

    result
  end

  protected

  def build_attributes(event_text, user)
    result = {
        text: event_text,
        happens_at: extract_date(event_text),
        link: extract_link(event_text),
        user: user
    }
    # TODO Issue and # 10 link
    result
  end

  def is_valid_text?(event_text)
    event_text =~ /(^|\s)#event([\s:\.\(\[\{!]|$)/i
  end
end
