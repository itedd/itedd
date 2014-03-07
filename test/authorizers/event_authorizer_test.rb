require 'test_helper'

class EventAuthorizerTest < ActiveSupport::TestCase

  test "should not be creatable by user" do
#    assert !EventAuthorizer.creatable_by?(users(:valid_user))
  end

  test "should be creatable by user" do
#    assert EventAuthorizer.creatable_by?(users(:valid_organizer))
  end

  test "should be updatable by user" do
#    assert events(:one).updatable_by?(users(:valid_organizer)), 'Organizers should be able to update an event.'
  end

  test "should not be updatable by user" do
#    assert !events(:one).updatable_by?(users(:valid_user)), 'Normal users are not allowed to update events.'
  end
end
