class FriendRequest < ApplicationRecord
    belongs_to :sender, class_name: 'User'
    belongs_to :recipient, class_name: 'User'
    has_many :friends, foreign_key: 'friend_request_id'
    
    ##validate uniqueness of sender_id and recipient_id
    validate :sender_and_recipient_uniqueness
    validate :friend_request_uniqueness
    validate :not_sending_to_someone_who_already_sent_to_you

    enum status: [:pending, :accepted, :rejected]
    
    private

        def sender_and_recipient_uniqueness
            if sender_id == recipient_id
                errors.add(:sender_id, "can't be the same as recipient")
            end
        end

        def friend_request_uniqueness
            if FriendRequest.where(sender: sender, recipient: recipient).exists?
                errors.add(:base, 'Friend request already exists')
            end
        end
        
        def not_sending_to_someone_who_already_sent_to_you
            if FriendRequest.where(sender: recipient, recipient: sender).exists?
                errors.add(:base, 'You already have a friend request from this user')
            end
        end


end
