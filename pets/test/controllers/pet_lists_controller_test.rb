require 'test_helper'

class PetListsControllerTest < ActionController::TestCase
  setup do
    @pet_list = pet_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pet_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pet_list" do
    assert_difference('PetList.count') do
      post :create, pet_list: {  }
    end

    assert_redirected_to pet_list_path(assigns(:pet_list))
  end

  test "should show pet_list" do
    get :show, id: @pet_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pet_list
    assert_response :success
  end

  test "should update pet_list" do
    patch :update, id: @pet_list, pet_list: {  }
    assert_redirected_to pet_list_path(assigns(:pet_list))
  end

  test "should destroy pet_list" do
    assert_difference('PetList.count', -1) do
      session[:pet_list_id] = @pet_list.id
      delete :destroy, id: @pet_list
    end

    assert_redirected_to adopt_path
  end
end
