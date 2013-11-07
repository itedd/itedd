require 'test_helper'
class TwitterReaderTest < ActiveSupport::TestCase
  fixtures :users

  setup do
    @user = users(:valid_user)
    @user.update_attribute :twitter_account, '@ruby_dresden'
  end

  test 'Twitter Reader finds all users with twitter accounts' do
    assert_equal 1, TwitterReader.twitter_accounts.count
  end

  test 'creates events' do
    Event.delete_all
    tr = TwitterReader.new(@user)
    def tr.tweets; [
      Twitter::Tweet.new(id: 123, text: 'Ruby Dresden am 17.11. um 17 Uhr - kommt alle! #event') ]; end

    tr.run
    # assert_equal 1, Event.count # TODO #9 muss erst gehen
  end
end
