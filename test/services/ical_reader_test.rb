require 'test_helper'
class IcalReaderTest < ActiveSupport::TestCase
  setup do
    @user_group = user_groups(:valid_user_group)
    @user_group.update_attribute :ical_url, 'https://www.c3d2.de/ical.ics'
    @user_group.update_attribute :logo, 'logo'
    Event.delete_all
  end

  test "works" do
    Timecop.freeze(Date.parse('2014-08-21')) do
      reader = IcalReader.new(@user_group)

      def reader.get(url)
        File.read('test/files/c3d2.ics')
      end

      reader.run
      assert @user_group.events.count > 0

      count = Event.count
      reader.run
      assert_equal count, @user_group.events.count
    end
  end
end
