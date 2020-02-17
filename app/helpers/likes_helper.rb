# frozen_string_literal: true

module LikesHelper
  def liked?(post)
    post.likes.find_by_user_id(current_user.id)
  end
end
