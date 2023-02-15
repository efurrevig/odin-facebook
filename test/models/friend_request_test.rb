require "test_helper"

class FriendRequestTest < ActiveSupport::TestCase
  setup do 
    @user1 = users(:one)
    @user2 = users(:two)
  end

  test "should save friend request" do
    assert FriendRequest.new(sender_id: @user1.id, recipient_id: @user2.id).save
  end

  test "should not save friend request if sender and recipient are the same" do
    assert_not FriendRequest.new(sender_id: @user1.id, recipient_id: @user1.id).save
  end

  test "should not save friend request if recipient already sent one to sender" do
    FriendRequest.create(sender_id: @user2.id, recipient_id: @user1.id)
    friend_request = FriendRequest.new(sender_id: @user1.id, recipient_id: @user2.id)
    assert_not friend_request.save
    assert_includes friend_request.errors.full_messages, 'You already have a friend request from this user'
  end
end
