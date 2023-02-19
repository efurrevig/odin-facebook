class Friend < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
  belongs_to :friend_request, foreign_key: 'friend_request_id'

  validates :friend_id, uniqueness: { scope: :user_id, message: "already exists" }
  validate :user_different_than_friend
  validate :friend_request_accepted

  private
    def user_different_than_friend
      if user_id == friend_id
        errors.add("User can't be same as friend")
      end
    end

    def friend_request_accepted
      friend_request = FriendRequest.find(self.friend_request_id)
      if friend_request.status != 'accepted'
        errors.add(:friend_request_id, "must be accepted")
      end
    end
end
