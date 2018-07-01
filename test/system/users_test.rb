require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "user login test" do
    @user = users(:michael)

    visit login_path
    assert_selector "h1", text: "Log in"

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'

    click_button 'Log in'
  end
end
