require 'test_helper'

class EventsControllerTest < ActionController::TestCase

  test "should render embedded without login" do
    get :embedded
    assert_response :success, @response.body
  end

end
