# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :content, length: { minimum: 5, maximum: 50 }
  belongs_to :user
  belongs_to :post
end
