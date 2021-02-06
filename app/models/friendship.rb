class Friendship < ApplicationRecord
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"

  scope :friends, -> { where("status = ?", true) }
  scope :not_friends, -> { where("status = ?", false) }

  validates :sender_id, :receiver_id, presence: true
  validates :sender_id, uniqueness: { scope: :receiver_id }
  validates :receiver_id, exclusion: { in: ->(u) { [u.sender_id] } }
end
