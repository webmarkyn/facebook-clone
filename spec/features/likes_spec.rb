# frozen_string_literal: true

require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'likes interacting', type: :feature do
  before :each do
    @user = User.create(email: 'something@cool.com', password: 'something123', password_confirmation: 'something123')
    @post_f = @user.posts.create(context: 'Test post 1')
    @post_s = @user.posts.create(context: 'Test post 2')
    @post_s.likes.create user_id: @user.id
    sign_in @user
  end

  describe 'liking post' do
    context 'When I press "Like" button' do
      it 'likes the post' do
        visit '/'
        click_link 'Like'
        expect(page).to have_content('Like was successfully created.')
      end
    end
  end
  describe 'unliking post' do
    context 'When I press "Unlike" button' do
      it 'Unlikes a post' do
        visit '/'
        click_link 'Unlike'
        expect(page).to have_content('Like was successfully destroyed.')
      end
    end
  end
end
