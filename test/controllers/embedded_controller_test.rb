require 'test_helper'

class EmbeddedControllerTest < ActionController::TestCase
  test "should render embedded without login" do
    get :embedded
    assert_response :success, @response.body
  end
end
