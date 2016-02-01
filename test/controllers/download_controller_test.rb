require 'test_helper'

class DownloadControllerTest < ActionController::TestCase
  test "should get doc" do
    get :doc
    assert_response :success
  end

end
