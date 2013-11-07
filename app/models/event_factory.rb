class EventFactory

  def create(event_text, user)
    raise ArgumentError("No user given") unless user.is_a?(User)

    if is_valid_text?(event_text)
      attributes = build_attributes(event_text)
      attributes.merge!( user: user )

      result = Event.new(attributes)

      if result.valid?
        result.save
      else
        result = nil
      end
    else
      result = nil
    end

    result
  end

  private

  def build_attributes(event_text)
    result = {text: event_text}
    # TODO Issue #9 extract date and link
    result
  end

  def is_valid_text?(event_text)
    event_text =~ /(^|\s)#?event([\s:\.\(\[\{!]|$)/i
  end

end