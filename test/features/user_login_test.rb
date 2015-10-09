require "test_helper"

class UserLoginTest < Capybara::Rails::TestCase
  def test_setup
    User.create(name: "Travis Haby",
               email: "travis@travishaby.com",
            password: "password")
  end

  def user
    @user ||= User.find_by(email: "travis@travishaby.com")
  end

  test "registered user can log in" do
    test_setup
    visit login_path

    within("#login_form") do
      fill_in "user[email]", with: "travis@travishaby.com"
      fill_in "user[password]", with: "password"
      click_on "Log In"
    end

    assert page.has_content?("Welcome, #{user.name}")
    assert_equal current_path, user_path(user)
  end

  test "unregistered user cant log in" do
    visit login_path

    within("#login_form") do
      fill_in "user[email]", with: "travis@travishaby.com"
      fill_in "user[password]", with: "password"
      click_on "Log In"
    end

    assert page.has_content?("Sorry, invalid login")
    assert_equal current_path, login_path
  end
end
