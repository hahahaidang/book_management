require 'test_helper'

class TestControllerTest < ActionController::TestCase
  test "should get test_page" do
    get :test_page
    assert_response :success
  end

end
