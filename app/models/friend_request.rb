class FriendRequest < ApplicationRecord
    belongs_to :sender, class_name: 'User'
    belongs_to :recipient, class_name: 'User'

    ##TO_DO: add validations for sender_id and recipient_id
    validates :sender_id, uniqueness: { scope: :recipient_id }

    enum status: [:pending, :accepted, :rejected]
end
