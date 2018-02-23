require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest


  test "should get new" do
    # /login画面を表示できる？
    get login_path
    assert_response :success
  end

end
