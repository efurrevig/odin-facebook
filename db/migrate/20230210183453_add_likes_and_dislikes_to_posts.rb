class AddLikesAndDislikesToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :likes, :integer, default: 0
    add_column :posts, :dislikes, :integer, default: 0
  end
end
