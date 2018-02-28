require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # 無効なアカウントではloginできないことを確認するテスト
  test "login with invalid information" do
    get login_path
    # sessions/newの画面ですか？
    assert_template 'sessions/new'
    # /loginにPOSTリクエストする
    post login_path,
    params: {
      session: { email: "", password: "" }
    }
    # sessions/newの画面を再表示できましたか？
    assert_template 'sessions/new'
    # flashに値が入ってますか？
    assert_not flash.empty?
    # .com/にアクセス
    get root_path
    # flashメッセージが消えてますか？
    assert flash.empty?
  end
end
