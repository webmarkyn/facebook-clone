require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: "something@cool.com", password: "12345678", password_confirmation: "12345678")
  end

  test "passwords should be similar" do
    @user.password = "12345679"
    test = @user.valid?
    assert_not test
  end

  test "email cant be blank" do
    @user.email = ""
    test = @user.valid?
    assert_not test
  end
end
