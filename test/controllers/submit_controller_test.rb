require 'test_helper'

class SubmitControllerTest < ActionController::TestCase
  test "should get kinderfeest" do
    get :kinderfeest
    assert_response :success
  end

  test "should get groupbooking" do
    get :groupbooking
    assert_response :success
  end

end
