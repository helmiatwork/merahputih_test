require 'test_helper'

class AdministratorTest < ActiveSupport::TestCase
  test "should not save administrator without email" do
    administrator = Administrator.new(password: "password")
    assert_not administrator.save, "Saved the administrator without an email"
  end

  test "should not save administrator without password" do
    administrator = Administrator.new(email: "admin@example.com")
    assert_not administrator.save, "Saved the administrator without a password"
  end

  test "should save administrator with email and password" do
    administrator = Administrator.new(email: "admin@example.com", password: "password")
    assert administrator.save, "Could not save the administrator with email and password"
  end
end