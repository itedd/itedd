require 'test_helper'
class TwitterReaderTest < ActiveSupport::TestCase
  fixtures :users

  setup do
    @user_group = user_groups(:valid_user_group)
    @user_group.update_attribute :twitter_account, '@ruby_dresden'
  end

  test 'Twitter Reader finds all users with twitter accounts' do
    assert_equal 1, TwitterReader.twitter_accounts.count
  end

  test 'creates events' do
    twitter_reader = TwitterReader.new(@user_group)

    def twitter_reader.profile_image_url
      'profile.png'
    end

    def twitter_reader.tweets
      [ {
        id: 123,
        text: 'Ruby Dresden am 17.11. um 17 Uhr - kommt alle! #event',
        url: 'http://t.co/1hrNAj4L8V'
      } ]
    end

    assert_difference "Event.count", 1 do
      twitter_reader.run
    end
    assert_equal 'profile.png', @user_group.logo

    event = Event.last
    assert_equal 'Ruby Dresden am 17.11. um 17 Uhr - kommt alle! #event', event.text
    assert_equal 'http://t.co/1hrNAj4L8V', event.link
    assert_equal '123', event.twitter_id

    assert_no_difference "Event.count" do
      twitter_reader.run
    end
  end
end
