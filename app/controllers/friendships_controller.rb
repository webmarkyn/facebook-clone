class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.outcoming_requests.build(requested_user_id: params[:user_id])
    if @friendship.save
      redirect_to users_friends_path(current_user), notice: "Friend request created"
    else
      redirect_to users_friends_path(current_user), alert: "Something went wrong"
    end
  end

  def accept
    if params[:requested_user_id] == current_user.id.to_s
      @friendship = Friendship.find([params[:requesting_user_id], params[:requested_user_id]])
      @friendship.mutual = true
      if @friendship.save
        redirect_to user_friend_requests_path, notice: "Success"
      else
        redirect_to user_friend_requests_path, alert: "Something went wrong"
      end
    else
      redirect_to user_friend_requests_path, alert: "You are not allowed to do this"
    end
  end

  def delete
    if params[:requested_user_id] == current_user.id.to_s || params[:requesting_user_id] == current_user.id.to_s
      @friendship = Friendship.find([params[:requesting_user_id], params[:requested_user_id]])
      @friendship.destroy
      redirect_to users_friends_path(current_user), notice: "You have deleted user from your friends"
    else
      redirect_to logged_in_root_path, alert: "You are not allowed to do this"
    end
  end

end
