class FriendRequest < ApplicationRecord
    belongs_to :sender, class_name: 'User'
    belongs_to :recipient, class_name: 'User'
    has_many :friends, foreign_key: 'friend_request_id'
    
    ##validate uniqueness of sender_id and recipient_id
    validate :sender_and_recipient_uniqueness
    validate :not_sending_to_someone_who_already_sent_to_you

    before_create :friend_request_uniqueness

    after_update :create_friendship, if: :accepted?

    enum status: [:pending, :accepted, :rejected]
    
    private

        def accepted?
            status == 'accepted'
        end

        def create_friendship
            Friend.create(user_id: sender_id, friend_id: recipient_id, friend_request_id: id)
            Friend.create(user_id: recipient_id, friend_id: sender_id, friend_request_id: id)
        end
        
        def sender_and_recipient_uniqueness
            if sender_id == recipient_id
                errors.add :sender_id, :invalid, message: "can't be the same as recipient"
            end
        end
        
        def not_sending_to_someone_who_already_sent_to_you
            if FriendRequest.where(sender_id: recipient_id, recipient_id: sender_id).exists?
                errors.add :base, :invalid, message: 'You already have a friend request from this user'
            end
        end

        def friend_request_uniqueness
            if FriendRequest.where(sender: sender, recipient: recipient).exists?
                errors.add(:base, 'Friend request already exists')
            end
        end


end
