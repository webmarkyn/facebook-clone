# frozen_string_literal: true

require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'comments interacting', type: :feature do
  before :each do
    @user = User.create(email: 'something@cool.com', password: 'something123', password_confirmation: 'something123')
    @post = @user.posts.create(context: 'Test post 1')
    @post.comments.create content: 'Hello World it\'s me', user_id: @user.id
    sign_in @user
  end

  describe 'commenting post' do
    context 'When I press comment the post' do
      it 'creates a new comment' do
        visit '/'
        fill_in "Content", with: 'Hello i\'s my new comment'
        click_button 'Create Comment'
        expect(page).to have_content('Comment was successfully created.')
      end
    end
  end

  describe 'deleting post' do
    context 'When I press comment the post' do
      it 'creates a new comment' do
        visit '/'
        click_link 'Delete comment'
        expect(page).to have_content('Comment was successfully destroyed.')
      end
    end
  end
end
