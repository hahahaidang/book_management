require 'test_helper'

class ManageBookControllerTest < ActionController::TestCase
  test "should get management_page" do
    get :Manage
    assert_response :success
  end

end
