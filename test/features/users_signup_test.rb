require "test_helper"
require "launchy"

class UsersSignupTest < Capybara::Rails::TestCase
  #IS THIS THE NEW SYNTAX FOR MINITEST??!?! THIS IS MADNESSS!
  test "invalid signup information" do
    visit signup_path
    within("#user_form") do
      fill_in 'user[name]', with: ""
      fill_in 'user[email]', with: "user@invalid"
      fill_in 'user[password]', with: "foo"
      fill_in 'user[password_confirmation]', with: "bar"
      click_on "Create my account"
    end

    refute page.has_content?("Welcome, ")
    within('#error_explanation') do
      assert page.has_content?("Name can't be blank")
      assert page.has_content?("Email is invalid")
    end
  end

  test "valid signup information" do
    visit signup_path
    assert_difference 'User.count', 1 do
      within("#user_form") do
        fill_in 'user[name]', with: "Example User"
        fill_in 'user[email]', with: "user@example.com"
        fill_in 'user[password]', with: "password"
        fill_in 'user[password_confirmation]', with: "password"
        click_on "Create my account"
      end
    end

    assert page.has_content?("Welcome, Example User")
    within(".flash_messages") do
      assert page.has_content?("Your account has been created.")
    end
  end
end
