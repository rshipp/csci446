require 'test_helper'

class FosterPetsControllerTest < ActionController::TestCase
  setup do
    @foster_pet = foster_pets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:foster_pets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create foster_pet" do
    assert_difference('FosterPet.count') do
      post :create, foster_pet: { pet_id: @foster_pet.pet_id }
    end

    assert_redirected_to foster_pet_path(assigns(:foster_pet))
  end

  test "should show foster_pet" do
    puts @foster_pet
    get :show, id: @foster_pet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @foster_pet
    assert_response :success
  end

  test "should update foster_pet" do
    patch :update, id: @foster_pet, foster_pet: { pet_id: @foster_pet.pet_id }
    assert_redirected_to foster_pet_path(assigns(:foster_pet))
  end

  test "should destroy foster_pet" do
    assert_difference('FosterPet.count', -1) do
      delete :destroy, id: @foster_pet
    end

    assert_redirected_to foster_pets_path
  end
end
