# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :delete_all
  has_many :likes
  has_many :comments
  has_many :incoming_requests, foreign_key: 'requested_user_id', class_name: 'Friendship'
  has_many :outcoming_requests, foreign_key: 'requesting_user_id', class_name: 'Friendship'
end
