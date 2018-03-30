require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  # 有効なアカウントではloginできることを確認するテスト
  test "login with valid information followed by logout" do
    # /loginの画面ですか？
    get login_path
    post login_path,
    params: {
      session: {
        email:    @user.email,
        password: 'password'
      }
    }
    assert is_logged_in?
    # リダイレクト先が正しいですか？
    assert_redirected_to @user
    # 実際にリダイレクトする
    follow_redirect!
    assert_template 'users/show'
    # login_pathがないのでログイン画面ではない
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)

    # ログアウトする
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url

    # 2番目のウィンドウでログアウトをクリックするユーザーをシミュレートする
    delete logout_path    
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
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
p    # flashメッセージが消えてますか？
    assert flash.empty?
  end
end
