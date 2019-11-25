# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user1 = User.create(email: 'something@cool.com', password: 'something123', password_confirmation: 'something123')
    @user2 = User.create(email: 'something2@cool.com', password: 'something123', password_confirmation: 'something123')
    @user3 = User.create(email: 'something3@cool.com', password: 'something123', password_confirmation: 'something123')
    @user4 = User.create(email: 'something4@cool.com', password: 'something123', password_confirmation: 'something123')
    @friendship1 = Friendship.create(requesting_user_id: @user3.id, requested_user_id: @user1.id)
    @friendship2 = Friendship.create(requesting_user_id: @user4.id, requested_user_id: @user1.id, mutual: true)
    @friendship3 = Friendship.create(requesting_user_id: @user1.id, requested_user_id: @user2.id)
  end
  context 'should not be valid' do
    describe 'when' do
      it 'has no email' do
        @user = User.new(email: '', password: '12345678', password_confirmation: '12345678')
        expect(@user).to_not be_valid
      end
      it 'has no password' do
        @user = User.new(email: 'something@cool.com', password: '', password_confirmation: '')
        expect(@user).to_not be_valid
      end
      it 'has different password and password_confirmation' do
        @user = User.new(email: 'something@cool.com', password: '12345678', password_confirmation: '12345679')
        expect(@user).to_not be_valid
      end
      it 'has no uniq email' do
        @user_f = User.create(email: 'something@cool.com', password: '12345678', password_confirmation: '12345678')
        @user_s = User.new(email: 'something@cool.com', password: 'something123', password_confirmation: 'something123')
        expect(@user_s).to_not be_valid
      end
    end
  end

  context 'user\'s methods' do
    it 'returns an array of friends' do
      expect(@user1.friends[0]).to eq @user4
    end
    it 'returns an array of friend requests' do
      expect(@user1.friend_requests[0]).to eq @user3
    end
    it 'returns an array of friend requests' do
      expect(@user1.friend_requests[0]).to eq @user3
    end
    describe 'friend? method' do
      it 'returns true if user provided is a friend' do
        expect(@user1.friend?(@user4)).to eq true
      end
      it 'returns falst if user provided isn\'t a friend' do
        expect(@user1.friend?(@user3)).to eq false
      end
    end
    describe 'request_gotten? method' do
      it 'returns true if user has request from privied user' do
        expect(@user1.request_gotten?(@user3)).to eq true
      end
      it 'returns false if user has no request from privied user' do
        expect(@user1.request_gotten?(@user4)).to eq false
      end
    end
    describe 'request_sent? method' do
      it 'returns true if user provided is a friend' do
        expect(@user1.request_sent?(@user2)).to eq true
      end
      it 'returns false if user provided isn\'t a friend' do
        expect(@user1.request_sent?(@user3)).to eq false
      end
    end
  end

  context 'should not be valid' do
    describe 'when' do
      it 'everything is provided' do
        @user = User.new(email: 'check@cool.com', password: 'something123', password_confirmation: 'something123')
        expect(@user).to be_valid
      end
    end
  end
end
