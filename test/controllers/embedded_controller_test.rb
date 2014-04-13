require 'test_helper'

class EmbeddedControllerTest < ActionController::TestCase
  test_access :index, :success=>[:admin, :anonymous, :jug, :rug] do
    get :index
  end
  test_access :embedded, :success=>[:admin, :anonymous, :jug, :rug] do
    get :show
  end
  test_access :embedded_calendar, :success=>[:admin, :anonymous, :jug, :rug] do
    get :calendar
  end
end
