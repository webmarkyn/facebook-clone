require 'rails_helper'
require 'capybara/rspec'

RSpec.describe "posts interacting", type: :feature do
  before :each do
    @user = User.create(email: 'something@cool.com', password: 'something123', password_confirmation: 'something123')
    @post = @user.posts.create(context: 'Test post 1')
    sign_in @user
  end

  describe 'creating new post' do
    context 'When I press "New Post" button' do
      it 'creates a new post' do
        visit '/'
        click_link 'Create New Post'
        fill_in 'Context', with: 'Just some text'
        click_button 'Create Post'
        expect(page).to have_content('Just some text')
      end
    end
  end
  describe 'deleting post' do
    context 'When I press "Destory" button' do
      it 'destroys a post', js: true do
        visit '/'
        accept_confirm do
          click_link 'Destroy'
        end
        expect(page).to have_content('Post was successfully destroyed.')
      end
    end
  end
  describe 'editing post' do
    context 'When I press "Destory" button' do
      it 'destroys a post', js: true do
        visit '/'
        click_link 'Edit'
        fill_in 'Context', with: 'Just some text'
        click_button 'Update Post'
        expect(page).to have_content('Post was successfully updated.')
      end
    end
  end
end
