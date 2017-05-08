require 'test_helper'

class SuggestControllerTest < ActionController::TestCase
  test "should get suggest_page" do
    get :suggest_page
    assert_response :success
  end

end
