require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  
  test "should not save user without name" do
    user = users(:one)
    user.name = nil
    assert_not user.save
  end

  test "should not save user without email" do
    user = users(:one)
    user.email = nil
    assert_not user.save
  end

  test "should not save user with invalid email" do
    user = users(:one)
    user.email = "invalid_email"
    assert_not user.save
  end

  test "should not save user without password" do
    user = users(:one)
    user.password = nil
    assert_not user.save
  end
end