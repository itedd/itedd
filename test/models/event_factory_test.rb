require 'test_helper'

class EventFactoryTest < ActiveSupport::TestCase

  setup do
    @factory = EventFactory.new
    
    def @factory.extract_date(string)
      Date.today
    end

    def @factory.extract_link(string)
      'http://www.itedd.de'
    end
  end

  test "create with valid event texts" do
    user = Organizer.first

    assert_not_nil @factory.createEvent("Dies ist ein gültiger #event text", user)
    assert_not_nil @factory.createEvent("Dies ist ein gültiger #event.", user)
    assert_not_nil @factory.createEvent("Dies ist ein gültiger #event:", user)
    assert_not_nil @factory.createEvent("Dies ist ein gültiger #event", user)
    assert_not_nil @factory.createEvent("Dies ist ein gültiger #event(", user)
    assert_not_nil @factory.createEvent("Dies ist ein gültiger #event[", user)
    assert_not_nil @factory.createEvent("Dies ist ein gültiger #event{", user)
    assert_not_nil @factory.createEvent("Dies ist ein gültiger #event!", user)
    assert_not_nil @factory.createEvent("#event am anfang", user)
    assert_not_nil @factory.createEvent("#event am anfang", user)
    assert_not_nil @factory.createEvent("#event", user)
    assert_not_nil @factory.createEvent("#Event", user)
    assert_not_nil @factory.createEvent("#event", user)
  end

  test "don't create with invalid event texts" do
    user = Organizer.first

    assert_raise ArgumentError do
      @factory.createEvent("Bei diesem #event fehlt der user", nil)
    end

    assert_nil @factory.createEvent("Dies ist kein gültiger event text", user)
    assert_nil @factory.createEvent("Dies ist kein gültiges#event", user)
    assert_nil @factory.createEvent("Dies ist kein gültiges ##event", user)
    assert_nil @factory.createEvent("Dies ist kein gültiges pevent", user)
    assert_nil @factory.createEvent("Dies ist kein gültiges evento", user)
    assert_nil @factory.createEvent("Dies ist kein gültiges #event)", user)
    assert_nil @factory.createEvent("Dies ist kein gültiges #event]", user)
    assert_nil @factory.createEvent("Dies ist kein gültiges #event}", user)
  end
end
