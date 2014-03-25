require 'test_helper'

class PetItemsControllerTest < ActionController::TestCase
  setup do
    @pet_item = pet_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pet_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pet_item" do
    assert_difference('PetItem.count') do
      #post :create, pet_item: { pet_id: @pet_item.pet_id, pet_list_id: @pet_item.pet_list_id }
      post :create, pet_item: {pet_id: pets(:one).id}
    end

    #assert_redirected_to adopt_path
    assert_redirected_to pet_list_path(assigns(:pet_item).pet_list)
  end

  test "should show pet_item" do
    get :show, id: @pet_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pet_item
    assert_response :success
  end

  test "should update pet_item" do
    patch :update, id: @pet_item, pet_item: { pet_id: @pet_item.pet_id }
    assert_redirected_to pet_item_path(assigns(:pet_item))
  end

  test "should destroy pet_item" do
    assert_difference('PetItem.count', -1) do
      delete :destroy, id: @pet_item
    end

    assert_redirected_to pet_items_path
  end
end
