# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  before :each do
    @user = User.create(email: 'something@cool.com', password: 'something123', password_confirmation: 'something123')
    @post = @user.posts.build context: 'Test post'
  end
  describe 'not valid' do
    context 'when' do
      it 'has no author' do
        @like = @post.likes.build
        expect(@like).to_not be_valid
      end
      it 'has no post' do
        @like = Like.new user_id: @user.id
        expect(@like).to_not be_valid
      end
    end
  end

  describe 'valid' do
    context 'when' do
      it 'has all of params' do
        @like = @post.likes.build user_id: @user.id
        expect(@like).to be_valid
      end
    end
  end
end
