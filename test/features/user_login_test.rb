require "test_helper"

class UserLoginTest < Capybara::Rails::TestCase
  test "registered user can log in" do
    test_setup
    visit login_path

    log_in_user

    assert page.has_content?("Welcome, #{user.name}")
    assert_equal current_path, user_path(user)
  end

  test "unregistered user cant log in" do
    visit login_path

    log_in_user

    # assert page.has_content?("Sorry, invalid login")
    assert_equal current_path, login_path
  end

  test "logged in user can log out" do
    test_setup
    visit login_path
    log_in_user

    click_on "Log Out"
    refute page.has_content?("Welcome, #{user.name}")
    assert current_path, login_path
  end
end
