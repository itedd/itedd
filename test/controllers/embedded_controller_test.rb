require 'test_helper'

class EmbeddedControllerTest < ActionController::TestCase
  test_access :index, :success=>[:admin, :anonymous, :jug, :rug] do
    get :index
  end
  test_access :embedded, :success=>[:admin, :anonymous, :jug, :rug] do
    get :embedded
  end
  test_access :embedded_calendar, :success=>[:admin, :anonymous, :jug, :rug] do
    get :embedded_calendar
  end
end
