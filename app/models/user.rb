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
  devise :omniauthable, omniauth_providers: %i[facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def friends
    friends_array = outcoming_requests.map { |request| request.requested_user if request.mutual }
    friends_array += incoming_requests.map { |request| request.requesting_user if request.mutual }
    friends_array.compact
  end

  def friend_requests
    friend_requests = incoming_requests.map { |request| request.requesting_user unless request.mutual }
    friend_requests.compact
  end

  def friend?(user)
    friends.include? user
  end

  def request_sent?(user)
    friend_requests = outcoming_requests.map { |request| request.requested_user unless request.mutual }
    friend_requests.include? user
  end

  def request_gotten?(user)
    friend_requests.include? user
  end
end
