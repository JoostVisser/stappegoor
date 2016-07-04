require 'test_helper'

class SubmitControllerTest < ActionController::TestCase
  test "should post kinderfeesten" do
    post :kinderfeest
    assert_response :success
  end

  test "should get groupbooking" do
    get :groupbooking
    assert_response :success
  end

end
