require 'test_helper'

class UserRememberedTest < ActionDispatch::IntegrationTest
  test "login with valid information followed by logout" do
    test_setup

    get login_path
    post login_path, user: { email: user.email, password: 'password' }
    assert is_logged_in?
    assert_redirected_to user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to login_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(user), count: 0
  end
end
