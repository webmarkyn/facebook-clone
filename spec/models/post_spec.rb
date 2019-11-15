# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  before :each do
    @user = User.create(email: 'something@cool.com', password: 'something123', password_confirmation: 'something123')
  end

  describe 'not valid' do
    context 'when' do
      it 'has no content' do
        @post = @user.posts.build context: ''
        expect(@post).to_not be_valid
      end
      it 'has no user' do
        @post = Post.new context: 'New Test Post'
        expect(@post).to_not be_valid
      end
      it 'context is too short' do
        @post = @user.posts.build context: '123'
        expect(@post).to_not be_valid
      end
      it 'context is too long' do
        @post = Post.new context: 'a' * 251
        expect(@post).to_not be_valid
      end
    end
  end

  describe 'valid' do
    context 'when' do
      it 'has context of valid length and user assigned' do
        @post = @user.posts.build context: 'Test post'
        expect(@post).to be_valid
      end
    end
  end
end
