require 'test_helper'

class WelcomesControllerTest < ActionController::TestCase

  test "should render show" do
    get :show
    assert_response :success, @response.body
  end

end
