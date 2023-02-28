class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :comment, optional: true

  validates :post_id, presence: true, unless: :comment_id
  validates :comment_id, presence: true, unless: :post_id
  
  with_options on: [:create] do
    validates_uniqueness_of :user_id, scope: :comment_id, if: :comment_id
    validates_uniqueness_of :user_id, scope: :post_id, if: :post_id
  end


end
