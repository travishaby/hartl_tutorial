require "test_helper"

class ClickLinksOnLandingPageTest < Capybara::Rails::TestCase
  test "sanity" do
    visit root_path
    assert page.has_content?("Sample App")
  end

  test "clicking navbar links" do
    visit root_path
    within("#navbar") do
      click_link "About"
    end

    assert_equal current_path, about_path
    message = "This is the sample application for the tutorial."
    assert page.has_content?(message)
  end
end
