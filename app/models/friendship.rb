# frozen_string_literal: true

class Friendship < ApplicationRecord
  before_create :mutual_default
  validate :duplicated_check
  belongs_to :requesting_user, foreign_key: 'requesting_user_id', class_name: 'User'
  belongs_to :requested_user, foreign_key: 'requested_user_id', class_name: 'User'
  self.primary_keys = :requesting_user_id, :requested_user_id
  def mutual_default
    self.mutual = false
  end
  def duplicated_check
    if Friendship.where(requested_user_id: self.requesting_user_id, 
                        requesting_user_id: self.requested_user_id)
        errors.add(:base, "Same request already exists")    end
  end
end
