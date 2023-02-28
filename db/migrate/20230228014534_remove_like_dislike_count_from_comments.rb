class RemoveLikeDislikeCountFromComments < ActiveRecord::Migration[7.0]
  def change
    remove_column :comments, :like_count, :integer
    remove_column :comments, :dislike_count, :integer
  end
end
