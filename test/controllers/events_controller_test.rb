require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  test_access :index_json, :success=>[:anonymous, :jug, :rug, :admin] do
    get :index, format: :json
  end
  test_access :index_html, :error=>[:anonymous, :jug, :rug, :admin] do
    get :index
  end
  test_access :edit, :redirect => :anonymous, :success=> [:admin, :jug], :deny=>:rug do
    get :edit, :id=>events(:jug).id
  end
  test_access :post, :redirect => :anonymous, :success=> [:admin, :jug], :deny=>:rug do
    post :edit, :id=>events(:jug).id
  end
  test_access :put, :redirect => :anonymous, :success=> [:admin, :jug], :deny=>:rug do
    put :edit, :id=>events(:jug).id
  end
  test_access :delete, :redirect => :anonymous, :success=> [:admin, :jug], :deny=>:rug do
    delete :edit, :id=>events(:jug).id
  end
  test_access :restore, :redirect => [:anonymous, :admin, :jug], :deny=>:rug do
    event = events(:jug)
    event.delete
    get :restore, :id=> event.id
  end

end
