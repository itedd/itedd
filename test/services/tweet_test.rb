require 'test_helper'

def d(day, month)
  Date.new(Date.today.year, month, day)
end

class TweetTest < ActiveSupport::TestCase
  setup do
    @user_group = user_groups(:valid_user_group)
    @user_group.update_attribute :twitter_account, '@ruby_dresden'
    @user_group.update_attribute :logo, 'logo'
  end

  [
      {
          name:     'Tweetzeit is vor Eventdatum',
          tweets:   [{id:1, url:'http://1', text:'Ruby Dresden am 17.1. um 17 Uhr - kommt alle! #event', created_at:d(16,1).to_time}],
          expected: [{url:'http://1', happens_at:d(17,1),text:'Ruby Dresden am 17.1. um 17 Uhr - kommt alle! #event'}]
      },
      {
          name:     'Tweetzeit ist nach Eventdatum',
          tweets:   [{id:1, url:'http://1', text:'Ruby Dresden am 17.1. um 17 Uhr - kommt alle! #event', created_at:Date.new(Date.today.year-1, 11, 16).to_time}],
          expected: [{url:'http://1', happens_at:d(17,1),text:'Ruby Dresden am 17.1. um 17 Uhr - kommt alle! #event'}]
      },
      {
          name:     'Simple 2',
          tweets:   [
              {id:1, url:'http://1', text:'am 17.5.2014 um 17 Uhr #event' },
              {id:2, url:'http://2', text:'am 17.6.2014 um 18 Uhr #event' },
          ],
          expected: [
              {url:'http://1', happens_at:d(17,5),text:'am 17.5.2014 um 17 Uhr #event'},
              {url:'http://2', happens_at:d(17,6),text:'am 17.6.2014 um 18 Uhr #event'},
          ]
      },
      {
          name:     'Doppelter Link',
          tweets:   [
              {id:1, url:'http://1', text:'am 17.5.2014 um 17 Uhr #event' },
              {id:2, url:'http://1', text:'am 17.6.2014 um 18 Uhr #event' },
          ],
          expected: [
              {url:'http://1', happens_at:d(17,6),text:'am 17.6.2014 um 18 Uhr #event'},
          ]
      },
      {
          name:     'Doppelte Twitter id',
          tweets:   [
              {id:1, url:'http://1', text:'am 17.5.2014 um 17 Uhr #event' },
              {id:1, url:'http://2', text:'am 17.6.2014 um 18 Uhr #event' },
          ],
          expected: [
              {url:'http://1', happens_at:d(17,5),text:'am 17.5.2014 um 17 Uhr #event'},
          ]
      },
      {
          name:     'Doppeltes Datum',
          tweets:   [
              {id:3, url:'http://3', text:'am 16.5.2014 um 17 Uhr #event' },
              {id:1, url:'http://1', text:'am 17.5.2014 um 17 Uhr #event' },
              {id:2, url:'http://2', text:'am 17.5.2014 um 18 Uhr #event' },
          ],
          expected: [
              {url:'http://3', happens_at:d(16,5),text:'am 16.5.2014 um 17 Uhr #event'},
              {url:'http://2', happens_at:d(17,5),text:'am 17.5.2014 um 18 Uhr #event'},
          ]
      },
  ].each do |sample|
    test "Testing tweets #{sample[:name]}" do
      Event.destroy_all
      reader = TwitterReader.new(@user_group)
      reader.define_singleton_method(:tweets) do
        sample[:tweets]
      end
      reader.run
      assert_equal sample[:expected].size, Event.count
      Event.oldest_first.each_with_index do |event, index|
        expected = sample[:expected][index]
        assert_equal expected[:happens_at], event.happens_at
        assert_equal expected[:text], event.text
        assert_equal expected[:url], event.link
      end
    end
  end

end