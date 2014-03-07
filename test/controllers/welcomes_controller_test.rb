require 'test_helper'

class WelcomesControllerTest < ActionController::TestCase

  test "should render index" do
    get :index
    assert_response :success, @response.body
  end

  test "should render show" do
    get :show
    assert_response :success, @response.body
  end

end
