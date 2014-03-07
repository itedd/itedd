require 'test_helper'

class UserGroupsControllerTest < ActionController::TestCase

  test "should redirect to sign in if not logged in" do
    get :edit
    assert_redirected_to new_user_session_path
  end

  test "should render edit" do
    sign_in User.first
    get :edit, :format=>1
    assert_response :success, @response.body
  end

end
