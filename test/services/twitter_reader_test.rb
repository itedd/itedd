require 'test_helper'
class TwitterReaderTest < ActiveSupport::TestCase
  fixtures :users
  test 'Twitter Reader finds all users with twitter accounts' do
    user = users(:valid_user)
    user.update_attribute :twitter_account, '@ruby_dresden'
    assert_equal 1, TwitterReader.twitter_accounts.count
  end
end
