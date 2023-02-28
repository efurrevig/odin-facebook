class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def liked?(user)
    !!self.likes.find{|like| like.user_id == user.id}
  end


  def like_or_dislike(user)
    like = likes.find_by(user_id: user.id)
    if like.nil?
      return nil
    else
      like.status
    end
  end
end
