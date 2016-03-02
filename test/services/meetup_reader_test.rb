require 'test_helper'
class MeetupReaderTest < ActiveSupport::TestCase
  setup do
    @user_group = user_groups(:valid_user_group)
    @user_group.update_attribute :meetup_url, 'http://www.meetup.com/de-DE/OK-Lab-Dresden/'
    Event.delete_all
  end

  test "works" do
    Timecop.freeze(Date.parse('2016-03-02')) do
      reader = MeetupReader.new(@user_group)

      def reader.get(url)
        JSON.parse File.read('test/files/meetup_oklab.json')
      end

      reader.run
      assert @user_group.events.count == 2

      count = Event.count
      reader.run
      assert_equal count, @user_group.events.count
    end
  end
end
