require 'test_helper'

class BaseReaderTest < ActiveSupport::TestCase

  setup do
    @base_reader = BaseReader.new()

    def @base_reader.extract_date(string)
      Date.today
    end

    def @base_reader.extract_link(string)
      'http://www.itedd.de'
    end
  end

  test "create with valid event texts" do
    user = User.first

    assert_not_nil @base_reader.createEvent("Dies ist ein gültiger #event text", user)
    assert_not_nil @base_reader.createEvent("Dies ist ein gültiger #event.", user)
    assert_not_nil @base_reader.createEvent("Dies ist ein gültiger #event:", user)
    assert_not_nil @base_reader.createEvent("Dies ist ein gültiger #event", user)
    assert_not_nil @base_reader.createEvent("Dies ist ein gültiger #event(", user)
    assert_not_nil @base_reader.createEvent("Dies ist ein gültiger #event[", user)
    assert_not_nil @base_reader.createEvent("Dies ist ein gültiger #event{", user)
    assert_not_nil @base_reader.createEvent("Dies ist ein gültiger #event!", user)
    assert_not_nil @base_reader.createEvent("#event am anfang", user)
    assert_not_nil @base_reader.createEvent("#event am anfang", user)
    assert_not_nil @base_reader.createEvent("#event", user)
    assert_not_nil @base_reader.createEvent("#Event", user)
    assert_not_nil @base_reader.createEvent("#event", user)
  end

  test "don't create with invalid event texts" do
    user = User.first

    assert_raise ArgumentError do
      @base_reader.createEvent("Bei diesem #event fehlt der user", nil)
    end

    assert_nil @base_reader.createEvent("Dies ist kein gültiger event text", user)
    assert_nil @base_reader.createEvent("Dies ist kein gültiges#event", user)
    assert_nil @base_reader.createEvent("Dies ist kein gültiges ##event", user)
    assert_nil @base_reader.createEvent("Dies ist kein gültiges pevent", user)
    assert_nil @base_reader.createEvent("Dies ist kein gültiges evento", user)
    assert_nil @base_reader.createEvent("Dies ist kein gültiges #event)", user)
    assert_nil @base_reader.createEvent("Dies ist kein gültiges #event]", user)
    assert_nil @base_reader.createEvent("Dies ist kein gültiges #event}", user)
  end
end