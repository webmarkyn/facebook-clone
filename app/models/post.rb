# frozen_string_literal: true

class Post < ApplicationRecord
  validates :context, presence: true, length: { maximum: 250, minimum: 5 }
  validates :user_id, presence: true
  belongs_to :user
end
