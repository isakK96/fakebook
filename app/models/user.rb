class User < ApplicationRecord
  has_many :posts

  # setting up the required associations between User & Friendship models for friend requests
  has_many :friend_sent,  class_name: 'Friendship',
                          foreign_key: 'sender_id',
                          inverse_of: 'sender',
                          dependent: :destroy
  has_many :friend_request, class_name: 'Friendship',
                            foreign_key: 'receiver_id',
                            inverse_of: 'receiver',
                            dependent: :destroy
  has_many :friends, -> { merge(Friendship.friends) },
           through: :friend_sent, source: :receiver
  has_many :pending_requests, -> { merge(Friendship.not_friends) },
           through: :friend_sent, source: :receiver
  has_many :received_requests, -> { merge(Friendship.not_friends) },
           through: :friend_request, source: :sender

  # validate presence of username and email
  validates :username, presence: true, uniqueness: true
  validates :email, :encrypted_password, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
