require 'test_helper'

class CarspecsControllerTest < ActionController::TestCase
  setup do
    @carspec = carspecs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:carspecs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create carspec" do
    assert_difference('Carspec.count') do
      post :create, carspec: { specname: @carspec.specname, spectype: @carspec.spectype }
    end

    assert_redirected_to carspec_path(assigns(:carspec))
  end

  test "should show carspec" do
    get :show, id: @carspec
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @carspec
    assert_response :success
  end

  test "should update carspec" do
    put :update, id: @carspec, carspec: { specname: @carspec.specname, spectype: @carspec.spectype }
    assert_redirected_to carspec_path(assigns(:carspec))
  end

  test "should destroy carspec" do
    assert_difference('Carspec.count', -1) do
      delete :destroy, id: @carspec
    end

    assert_redirected_to carspecs_path
  end
end
