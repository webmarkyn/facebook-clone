# frozen_string_literal: true

class Post < ApplicationRecord
  default_scope { order(created_at: :desc) }
  validates :context, presence: true, length: { maximum: 250, minimum: 5 }
  belongs_to :user
  has_many :likes
  has_many :comments
end
