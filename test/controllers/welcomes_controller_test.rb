require 'test_helper'

class WelcomesControllerTest < ActionController::TestCase
  test_access :show, :success=>[:admin, :anonymous, :jug, :rug] do
    get :show
  end
  test_access :faq, :success=>[:admin, :anonymous, :jug, :rug] do
    get :faq
  end
  test_access :impressum, :success=>[:admin, :anonymous, :jug, :rug] do
    get :impressum
  end

end
