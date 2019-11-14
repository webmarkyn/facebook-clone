require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = User.new(email: "something@cool.com", password: "12345678", password_confirmation: "12345678")
    @post = @user.posts.build(id: 1)
    sign_in @user
  end

end
