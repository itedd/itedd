require 'test_helper'

class UserGroupAdminsControllerTest < ActionController::TestCase

  def setup
    @user_group = user_groups(:jug)
  end

  test_access :index, :success=>[:admin,:anonymous, :jug, :rug] do
    get :index
  end

  test_access :edit, :success=>[:admin, :jug], :deny=>[:rug], :redirect=>[:anonymous] do
    get :edit, id: @user_group.id
  end

  test_access :post, :success=>[:admin, :jug], :deny=>[:rug], :redirect=>[:anonymous]do
    post :edit, id: @user_group.id
  end

  test_access :put, :success=>[:admin, :jug], :deny=>[:rug], :redirect=>[:anonymous]do
    put :edit, id: @user_group.id
  end

  test_access :delete, :error=>[:admin,:jug, :rug,:anonymous] do
    delete :edit, id: @user_group.id
  end

  test 'should delete user group' do
    sign_in users(:admin)
    delete :destroy, id: @user_group.id
    assert_nil UserGroup.where(id: @user_group.id).first
  end
end
