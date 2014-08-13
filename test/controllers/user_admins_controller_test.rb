require 'test_helper'

class UserAdminsControllerTest < ActionController::TestCase
  test_access :index, :success=>[:admin, :jug, :rug, :anonymous] do
    get :index
  end
  test_access :edit, :success=>[:admin], :deny=>[:jug, :rug], :redirect=>[:anonymous] do
    get :edit, :id=>users(:jug).id
  end
  test_access :post, :success=>[:admin], :deny=>[:jug, :rug], :redirect=>[:anonymous]do
    post :edit, :id=>users(:jug).id
  end
  test_access :put, :success=>[:admin], :deny=>[:jug, :rug], :redirect=>[:anonymous]do
    put :edit, :id=>users(:jug).id
  end
  test_access :delete, :error=>[:admin,:jug, :rug,:anonymous] do
    delete :edit, :id=>users(:jug).id
  end
end
