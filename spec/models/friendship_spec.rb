# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before :each do
    @user1 = User.create(email: 'something@cool.com', password: 'something123', password_confirmation: 'something123')
    @user2 = User.create(email: 'something2@cool.com', password: 'something123', password_confirmation: 'something123')
    @user3 = User.create(email: 'something3@cool.com', password: 'something123', password_confirmation: 'something123')
    @init = @user1.outcoming_requests.create requested_user_id: @user2.id
  end
  describe 'not valid' do
    context 'when' do
      it 'has a duplicate in database' do
        @friendship = @user1.outcoming_requests.build requested_user_id: @user2.id
        expect(@friendship).to_not be_valid
      end
      it 'has a reversed duplicate in database' do
        @friendship = @user2.outcoming_requests.build requested_user_id: @user1.id
        expect(@friendship).to_not be_valid
      end
    end
  end

  describe 'valid' do
    context 'when' do
      it 'has no duplicate' do
        @friendship = @user1.outcoming_requests.build requested_user_id: @user3.id
        expect(@friendship).to be_valid
      end
    end
  end
end
