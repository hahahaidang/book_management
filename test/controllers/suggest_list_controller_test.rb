require 'test_helper'

class SuggestListControllerTest < ActionController::TestCase
  test "should get suggest_list_page" do
    get :suggest_list_page
    assert_response :success
  end

end
