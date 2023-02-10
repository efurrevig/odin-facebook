class ChangeDefaultValueOfLikesAndDislikes < ActiveRecord::Migration[7.0]
  def change
    change_column_default :comments, :likes, 0
    change_column_default :comments, :dislikes, 0
  end
end
