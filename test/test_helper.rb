ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails/capybara'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

end

def test_setup
  User.create(name: "Travis Haby",
             email: "travis@travishaby.com",
          password: "password")
end

def user
  @user ||= User.find_by(email: "travis@travishaby.com")
end

def log_in_user
  within("#login_form") do
    fill_in "user[email]", with: "travis@travishaby.com"
    fill_in "user[password]", with: "password"
    click_on "Log In"
  end
end
