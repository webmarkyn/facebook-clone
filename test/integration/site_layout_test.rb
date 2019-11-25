# frozen_string_literal: true

require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.new(email: 'test@google.com')
  end

  test 'redirects to sign_in page when not logged in' do
    get root_path
    assert_redirected_to '/users/sign_in'
  end

  test 'redirects to posts page when logged in' do
    sign_in(@user)
    get root_path
    assert_redirected_to '/posts'
  end

  test 'layout links when loged in' do
    sign_in @user
    get posts_path
    assert_select 'a[href=?]', new_post_path
    assert_select 'a[href=?]', destroy_user_session_path
    assert_select 'a[href=?]', posts_path
  end

  test 'layout links when not loged in' do
    sign_out @user
    get new_user_session_path
    assert_select 'a[href=?]', new_user_session_path
  end

  test 'loggin in with incorrect credintials' do
    post '/users/sign_in', params: { email: 'wrong@wrong.com', password: '123' }
    assert_equal 'Invalid Email or password.', flash[:alert]
  end
end
