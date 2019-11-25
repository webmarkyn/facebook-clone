# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def friends
    @user = User.find(params[:user_id])
    @friends = @user.friends
    puts "THIS IS #{@friends}"
  end

  def friend_requests
    @user = current_user
    @friend_requests = @user.friend_requests
  end
end
