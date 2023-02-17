class AddFriendRequestIdToFriends < ActiveRecord::Migration[7.0]
  def change
    add_column :friends, :friend_request_id, :integer, null: false
  end
end
