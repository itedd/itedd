require 'test_helper'

class UserGroupTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should ensure_length_of(:name).is_at_least(10).is_at_most(100)

  should have_many :events

  test 'should accept valid twitter account' do
    user_group = user_groups(:valid_user_group)
    user_group.twitter_account = '@ruby_dresden'
    user_group.valid?
    assert user_group.errors[:twitter_account].blank?

    user_group.twitter_account = 'ruby dresden'
    user_group.valid?
    assert user_group.errors[:twitter_account].present?
  end

end
