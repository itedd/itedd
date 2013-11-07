require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "should require name, password and email" do
    user = User.new
    assert !user.valid?

    user.username = "Bruce Wayne"
    assert !user.valid?

    user.email = "bruce.wayne@wayne.com"
    assert !user.valid?

    user.password = "Test_1234"
    assert user.valid?, user.errors.inspect

    user.password_confirmation = "Test_1234"
    assert user.valid?
  end

  #test "should have a valid fixture" do
  #  user = users(:valid_user)
  #  #user.password = '1'
  #  assert user.valid? , user.errors.inspect
  #end

  test "should not accept to short password" do
    user = users(:valid_user)
    user.password = '1'
    assert !user.valid?, "Password should not be accepted!"
  end

end
