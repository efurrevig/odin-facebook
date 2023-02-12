class RenameLikesDislikesToLikeCountDislikeCount < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :likes, :like_count
    rename_column :posts, :dislikes, :dislike_count
    rename_column :comments, :likes, :like_count
    rename_column :comments, :dislikes, :dislike_count
  end
end
