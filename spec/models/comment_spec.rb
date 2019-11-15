require 'rails_helper'

RSpec.describe Comment, type: :model do
  before :each do
    @user = User.create(email: 'something@cool.com', password: 'something123', password_confirmation: 'something123')
    @post = @user.posts.build context: 'Test post'
  end
  describe 'not valid' do
    context 'when' do
      it "has no author" do
        @comment = @post.comments.build content: 'Hello World!Here'
        expect(@comment).to_not be_valid
      end
      it "has no content" do
        @comment = @post.comments.build user_id: @user.id
        expect(@comment).to_not be_valid
      end
      it "has no post" do
        @comment = Comment.new user_id: @user.id, content: 'Hello World I\'m here'
        expect(@comment).to_not be_valid
      end
    end
  end

  describe 'valid' do
    context 'when' do
      it 'has all of params' do
        @comment = @post.comments.build content: 'Hello World!Here', user_id: @user.id
        expect(@comment).to be_valid
      end
    end
  end
end
