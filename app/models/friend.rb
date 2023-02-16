class Friend < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  validate :user_different_than_friend

  private
    def user_different_than_friend
      if user_id == friend_id
        errors.add(:user_id, "can't be the same as friend")
      end
    end
end
