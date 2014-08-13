require 'test_helper'

class UserGroupAdminsControllerTest < ActionController::TestCase
  test_access :index, :success=>[:admin,:anonymous, :jug, :rug] do
    get :index
  end
  test_access :edit, :success=>[:admin, :jug], :deny=>[:rug], :redirect=>[:anonymous] do
    get :edit, :id=>user_groups(:jug).id
  end
  test_access :post, :success=>[:admin, :jug], :deny=>[:rug], :redirect=>[:anonymous]do
    post :edit, :id=>user_groups(:jug).id
  end
  test_access :put, :success=>[:admin, :jug], :deny=>[:rug], :redirect=>[:anonymous]do
    put :edit, :id=>user_groups(:jug).id
  end
  test_access :delete, :error=>[:admin,:jug, :rug,:anonymous] do
    delete :edit, :id=>user_groups(:jug).id
  end
end
