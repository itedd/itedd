require 'test_helper'

class UserGroupsControllerTest < ActionController::TestCase
  test_access :show, :success=>[:anonymous, :jug, :rug, :admin] do
    get :show, :id=>user_groups(:jug).id
  end
  test_access :edit, :redirect => :anonymous, :success=> [:admin, :jug], :deny=>:rug do
    get :edit, :id=>user_groups(:jug).id
  end
  test_access :post, :redirect => :anonymous, :success=> [:admin, :jug], :deny=>:rug do
    post :edit, :id=>user_groups(:jug).id
  end
  test_access :put, :redirect => :anonymous, :success=> [:admin, :jug], :deny=>:rug do
    put :edit, :id=>user_groups(:jug).id
  end
  test_access :delete, :error=>[:anonymous, :admin, :jug, :rug] do
    delete :edit, :id=>user_groups(:jug).id
  end
end
