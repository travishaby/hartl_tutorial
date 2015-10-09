require "test_helper"

class UserTest < ActiveSupport::TestCase
  def user
    @user ||= User.new(name: "Example User",
                      email: "user@example.com",
                   password: "password")
  end

  def test_valid
    assert user.valid?
  end

  def test_a_name_should_be_present
    user.name = ""
    assert_not user.valid?
  end

  def test_an_email_should_be_present
    user.email = "     "
    assert_not user.valid?
  end

  def test_name_cant_be_too_long
    user.name = "a" * 51
    assert_not user.valid?
  end

  def test_email_cant_be_too_long
    user.email = "a" * 244 + "@example.com"
    assert_not user.valid?
  end

  def test_valid_emails_are_accepted
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email = valid_address
      assert user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  def test_invalid_emails_are_not_accepted
    invalid_addresses = %w[notvalidexample.com USER@NOTCHILLBRO
                         first.last@foo alice@bob@baz.cn]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      refute user.valid?, "#{invalid_address.inspect} should be valid"
    end
  end

  def test_email_addresses_should_be_saved_as_lower_case
    mixed_case_email = "Foo@ExAMPle.CoM"
    user.email = mixed_case_email
    user.save
    assert_equal mixed_case_email.downcase, user.reload.email
  end

  def test_email_address_should_be_unique
    duplicate_user = user.dup
    duplicate_user.email = user.email.upcase
    user.save
    refute duplicate_user.valid?
  end

  def test_password_cant_be_blank
    user.password = user.password_confirmation = " " * 9
    assert_not user.valid?
  end

  def test_password_must_be_long_enough
    user.password = user.password_confirmation = "a" * 5
    assert_not user.valid?
  end

  def test_user_has_default_role_of_non_admin
    assert_equal user.role, "default"
  end

  def test_user_can_be_admin
    user.role = "admin"
    assert_equal user.role, "admin"
  end
end
