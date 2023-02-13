class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post, optional: true
  belongs_to :comment, optional: true

  validates :post_id, presence: true, unless: :comment_id
  validates :comment_id, presence: true, unless: :post_id

  validates_uniqueness_of :user_id, scope: [:post_id], if: :post_id
  validates_uniqueness_of :user_id, scope: [:comment_id], if: :comment_id

  after_create :increment_like_count
  after_create :increment_dislike_count
  after_destroy :decrement_like_count
  after_destroy :decrement_dislike_count
  after_update :update_like_dislike_count

  def update_like_dislike_count
    if self.status
      self.post.increment!(:like_count) if self.post
      self.comment.increment!(:like_count) if self.comment
      self.post.decrement!(:dislike_count) if self.post
      self.comment.decrement!(:dislike_count) if self.comment
    else
      self.post.increment!(:dislike_count) if self.post
      self.comment.increment!(:dislike_count) if self.comment
      self.post.decrement!(:like_count) if self.post
      self.comment.decrement!(:like_count) if self.comment
    end
  end


  def increment_like_count
    if self.status
      self.post.increment!(:like_count) if self.post
      self.comment.increment!(:like_count) if self.comment
    end
  end

  def increment_dislike_count
    if !self.status
      self.post.increment!(:dislike_count) if self.post
      self.comment.increment!(:dislike_count) if self.comment
    end
  end

  def decrement_like_count
    if self.status
      self.post.decrement!(:like_count) if self.post
      self.comment.decrement!(:like_count) if self.comment
    end
  end

  def decrement_dislike_count
    if !self.status
      self.post.decrement!(:dislike_count) if self.post
      self.comment.decrement!(:dislike_count) if self.comment
    end
  end
end
