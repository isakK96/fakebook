class User < ApplicationRecord
  has_many :posts

  validates :username, presence: true, uniqueness: true
  validates :email, :encrypted_password, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end