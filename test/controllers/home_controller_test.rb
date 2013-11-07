require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test "should render index" do
    get :index
    assert_response :success, @response.body
  end

end
