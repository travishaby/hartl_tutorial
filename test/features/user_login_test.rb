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

  test "user can log in" do
    test_setup
    visit login_path

    within("#login_form") do
      fill_in "session[email]", with: "travishaby"
      fill_in "session[password]", with: "password"
      click_on "Log In"
    end

    assert_equal current_path, user_path(user)
  end
end
