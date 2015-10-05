require "test_helper"

class ClickLinksOnLandingPageTest < Capybara::Rails::TestCase
  def test_sanity
    visit root_path
    assert page.has_content?("Sample App")
  end

  def test_clicking_navbar_links
    visit root_path
    within("#navbar") do
      click_link "About"
    end

    assert_equal current_path, about_path
    assert_equal "About | Ruby on Rails Tutorial Sample App", page.title
    message = "This is the sample application for the tutorial."
    assert page.has_content?(message)

    visit root_path
    within("#navbar") do
      click_link "Help"
    end

    assert_equal current_path, help_path
    assert_equal "Help | Ruby on Rails Tutorial Sample App", page.title
    message = "Help"
    assert page.has_content?(message)
  end

  def test_something_else

  end
end
