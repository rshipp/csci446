require 'test_helper'

class AdoptControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#columns #side a', :minimum => 2
    assert_select '#main .entry', 2
    assert_select 'h3', 'MyString'
  end

end
