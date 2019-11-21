# frozen_string_literal: true

require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'likes interacting', type: :feature do
  before :each do
    @user1 = User.create(email: 'something@cool.com', password: 'something123', password_confirmation: 'something123')
    @user2 = User.create(email: 'something2@cool.com', password: 'something123', password_confirmation: 'something123')
    @user3 = User.create(email: 'something3@cool.com', password: 'something123', password_confirmation: 'something123')
    @user4 = User.create(email: 'something4@cool.com', password: 'something123', password_confirmation: 'something123')
    @friendship1 = Friendship.create(requesting_user_id: @user3.id, requested_user_id: @user1.id )
    @friendship2 = Friendship.create(requesting_user_id: @user4.id, requested_user_id: @user1.id, mutual: true )
    sign_in @user1
  end

  describe 'adding friend' do
    context 'When I press "Send Friend request" link' do
      it 'sends a friend request' do
        visit '/users/'
        click_link 'Send Friend request'
        expect(page).to have_content('Friend request created')
      end
    end
  end
  describe 'Accepting friend request' do
    context 'When I press "Accept Request" link' do
      it 'Accepts a friend request' do
        visit "/friend_requests"
        click_link 'Accept Request'
        expect(page).to have_content('Success')
      end
    end
  end
  describe 'deleting from friends' do
    context 'When I press "Delete from friends" link' do
      it 'Deletes a user from friends list' do
        visit "/users/#{@user1.id}/friends"
        click_link 'Delete from friends'
        expect(page).to have_content('You have deleted user from your friends')
      end
    end
  end
end
