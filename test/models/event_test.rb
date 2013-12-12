require 'test_helper'

class EventTest < ActiveSupport::TestCase

  should belong_to(:organizer)
  should validate_presence_of(:happens_at)
  should validate_presence_of(:link)
  should validate_presence_of(:text)
  should validate_presence_of(:organizer)
  should ensure_length_of(:text).is_at_most(200)
  should ensure_length_of(:link).is_at_most(200)

end
