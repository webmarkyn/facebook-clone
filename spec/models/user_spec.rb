# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
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

  context 'should not be valid' do
    describe 'when' do
      it 'everything is provided' do
        @user = User.new(email: 'something@cool.com', password: 'something123', password_confirmation: 'something123')
        expect(@user).to be_valid
      end
    end
  end
end
