require 'test_helper'

class EventFactoryTest < ActiveSupport::TestCase

  test "create with valid event texts" do
    user = User.first
    factory = EventFactory.new()

    def factory.build_attributes(string)
      # TODO setup valid moching framework
      {text: "blubb", happens_at: Date.today, link: "www.example.com"}
    end

    assert_not_nil factory.create("Dies ist ein gültiger event text", user)
    assert_not_nil factory.create("Dies ist ein gültiger #event text", user)
    assert_not_nil factory.create("Dies ist ein gültiger #event.", user)
    assert_not_nil factory.create("Dies ist ein gültiger #event:", user)
    assert_not_nil factory.create("Dies ist ein gültiger #event", user)
    assert_not_nil factory.create("Dies ist ein gültiger #event(", user)
    assert_not_nil factory.create("Dies ist ein gültiger #event[", user)
    assert_not_nil factory.create("Dies ist ein gültiger #event{", user)
    assert_not_nil factory.create("Dies ist ein gültiger #event!", user)
    assert_not_nil factory.create("#event am anfang", user)
    assert_not_nil factory.create("event am anfang", user)
    assert_not_nil factory.create("event", user)
    assert_not_nil factory.create("Event", user)
    assert_not_nil factory.create("#event", user)
  end

  test "don't create with invalid event texts" do
    user = User.first
    factory = EventFactory.new()

    def factory.build_attributes(string)
      # TODO setup valid moching framework
      {text: "blubb", happens_at: Date.today, link: "www.example.com"}
    end

    assert_nil factory.create("Dies ist kein gültiges#event", user)
    assert_nil factory.create("Dies ist kein gültiges ##event", user)
    assert_nil factory.create("Dies ist kein gültiges pevent", user)
    assert_nil factory.create("Dies ist kein gültiges evento", user)
    assert_nil factory.create("Dies ist kein gültiges event)", user)
    assert_nil factory.create("Dies ist kein gültiges event]", user)
    assert_nil factory.create("Dies ist kein gültiges event}", user)
  end
end