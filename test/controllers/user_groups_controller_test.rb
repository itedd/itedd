require 'test_helper'

class UserGroupsControllerTest < ActionController::TestCase

  test "should redirect to sign in if not logged in" do
    get :edit, :id=>1
    assert_redirected_to new_user_session_path
  end

  test "should render edit for organizer" do
    sign_in users(:valid_organizer)
    get :edit, :id=>1
    assert_response :success, @response.body
  end

  test "should not render edit for normal user" do
    sign_in users(:valid_user)
    assert_raise CanCan::AccessDenied do
      get :edit, :id=>1
    end
  end

end
