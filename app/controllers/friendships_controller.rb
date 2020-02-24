# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.outcoming_requests.build(requested_user_id: params[:user_id])
    if @friendship.save
      redirect_to users_friends_path(current_user), notice: 'Friend request created'
    else
      redirect_to users_friends_path(current_user), alert: 'Something went wrong'
    end
  end

  def accept
    if params[:requested_user_id] == current_user.id.to_s
      @friendship = Friendship.find([params[:requesting_user_id], params[:requested_user_id]])
      @friendship.mutual = true
      if @friendship.save
        redirect_to user_friend_requests_path, notice: 'Success'
      else
        redirect_to user_friend_requests_path, alert: 'Something went wrong'
      end
    else
      redirect_to user_friend_requests_path, alert: 'You are not allowed to do this'
    end
  end

  def delete
    if params[:friend_id] == current_user.id.to_s || params[:user_id] == current_user.id.to_s
      @friendship = nil
      if Friendship.exists?(:requesting_user_id => params[:friend_id], :requested_user_id => params[:user_id])
        @friendship = Friendship.find_by(requesting_user_id: params[:friend_id], requested_user_id: params[:user_id])
      elsif Friendship.exists?(:requesting_user_id => params[:user_id], :requested_user_id => params[:friend_id])
        @friendship = Friendship.find_by(requesting_user_id: params[:user_id], requested_user_id: params[:friend_id])
      end
      if @friendship.nil?
        redirect_to users_friends_path(current_user), alert: 'This user is not your friend'
      end
      @friendship.destroy
      redirect_to users_friends_path(current_user), notice: 'You have deleted user from your friends'
    else
      redirect_to logged_in_root_path, alert: 'You are not allowed to do this'
    end
  end
end
