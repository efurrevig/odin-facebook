class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :comment, optional: true

  validates :post_id, presence: true, unless: :comment_id
  validates :comment_id, presence: true, unless: :post_id
end
