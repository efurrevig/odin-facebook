class Comment < ApplicationRecord
  paginates_per 3
  belongs_to :post, counter_cache: true
  belongs_to :user

  has_many :likes, dependent: :destroy

  def liked?(user)
    !!self.likes.find{|like| like.user_id == user.id}
  end


  def like_or_dislike(user)
    like = likes.find_by(user_id: user.id)
    if like.nil?
      return nil
    else
      return like.status
    end
  end
  
end
