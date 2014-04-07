require 'test_helper'

class ApproveControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get approve" do
    get :approve
    assert_response :success
  end

end
