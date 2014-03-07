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
    user_group = UserGroup.first

    assert_not_nil @base_reader.build_event("Dies ist ein gültiger #event text", user_group)
    assert_not_nil @base_reader.build_event("Dies ist ein gültiger #event.", user_group)
    assert_not_nil @base_reader.build_event("Dies ist ein gültiger #event:", user_group)
    assert_not_nil @base_reader.build_event("Dies ist ein gültiger #event", user_group)
    assert_not_nil @base_reader.build_event("Dies ist ein gültiger #event(", user_group)
    assert_not_nil @base_reader.build_event("Dies ist ein gültiger #event[", user_group)
    assert_not_nil @base_reader.build_event("Dies ist ein gültiger #event{", user_group)
    assert_not_nil @base_reader.build_event("Dies ist ein gültiger #event!", user_group)
    assert_not_nil @base_reader.build_event("#event am anfang", user_group)
    assert_not_nil @base_reader.build_event("#event am anfang", user_group)
    assert_not_nil @base_reader.build_event("#event", user_group)
    assert_not_nil @base_reader.build_event("#Event", user_group)
    assert_not_nil @base_reader.build_event("#event", user_group)
  end

  test "don't create with invalid event texts" do
    user_group = UserGroup.first

    assert_raise ArgumentError do
      @base_reader.build_event("Bei diesem #event fehlt der user_group", nil)
    end

    assert_nil @base_reader.build_event("Dies ist kein gültiger event text", user_group)
    assert_nil @base_reader.build_event("Dies ist kein gültiges#event", user_group)
    assert_nil @base_reader.build_event("Dies ist kein gültiges ##event", user_group)
    assert_nil @base_reader.build_event("Dies ist kein gültiges pevent", user_group)
    assert_nil @base_reader.build_event("Dies ist kein gültiges evento", user_group)
    assert_nil @base_reader.build_event("Dies ist kein gültiges #event)", user_group)
    assert_nil @base_reader.build_event("Dies ist kein gültiges #event]", user_group)
    assert_nil @base_reader.build_event("Dies ist kein gültiges #event}", user_group)
  end
end
