class RemoveLikeDislikeCountFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :like_count, :integer
    remove_column :posts, :dislike_count, :integer
  end
end
