require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  # 有効なアカウントではloginできないことを確認するテスト
  test "login with valid information" do
    # /loginの画面ですか？
    get login_path
    post login_path,
    params: {
      session: {
        email:    @user.email,
        password: 'password'
      }
    }
    # リダイレクト先が正しいですか？
    assert_redirected_to @user
    # 実際にリダイレクトする
    follow_redirect!
    assert_template 'users/show'
    # login_pathがないのでログイン画面ではない
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

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
