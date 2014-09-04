require 'test_helper'

class UserAdminsControllerTest < ActionController::TestCase

  def setup
    @user = users(:jug)
  end

  test_access :index, :success=>[:admin], :deny=>[:jug, :rug], :redirect=>[:anonymous] do
    get :index
  end

  test_access :edit, :success=>[:admin], :deny=>[:jug, :rug], :redirect=>[:anonymous] do
    get :edit, id: @user.id
  end

  test_access :post, :success=>[:admin], :deny=>[:jug, :rug], :redirect=>[:anonymous]do
    post :edit, id: @user.id
  end

  test_access :put, :success=>[:admin], :deny=>[:jug, :rug], :redirect=>[:anonymous]do
    put :edit, id: @user.id
  end

  test_access :delete, :error=>[:admin,:jug, :rug,:anonymous] do
    delete :edit, id: @user.id
  end

  test_access :destroy, :deny=>[:jug, :rug], :redirect=>[:admin, :anonymous] do
    delete :destroy, id: @user.id
  end

  test 'should delete user' do
    sign_in users(:admin)
    delete :destroy, id: @user.id
    assert_nil User.where(id: @user.id).first
  end
end
