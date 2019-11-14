# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = User.new(id: 1, email: 'something@cool.com', password: '12345678', password_confirmation: '12345678')
    @post = @user.posts.build(context: 'Test post')
  end

  test 'post should have user_id of user' do
    assert_equal @post.user_id, @user.id
  end

  test 'context is too short' do
    @post.context = ''
    assert_not @post.valid?
  end

  test 'No user_id' do
    @post.user_id = nil
    assert_not @post.valid?
  end
end
