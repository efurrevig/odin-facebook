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

  #enum status: [:pending, :accepted, :rejected]
  test "should return status pending" do
    friend_request = FriendRequest.new(sender_id: @user1.id, recipient_id: @user2.id)
    assert friend_request.save
    assert_equal friend_request.status, 'pending'
  end
  
  test "should return status accepted" do
    friend_request = FriendRequest.new(sender_id: @user1.id, recipient_id: @user2.id)
    friend_request.status = 1
    assert friend_request.save
    assert_equal friend_request.status, 'accepted'
  end

  test "should return status rejected" do
    friend_request = FriendRequest.new(sender_id: @user1.id, recipient_id: @user2.id)
    friend_request.status = 2
    assert friend_request.save
    assert_equal friend_request.status, 'rejected'
  end

  test "should create two friends when friend request is accepted" do
    assert_difference 'Friend.count', 2 do
      friend_request = FriendRequest.create(sender_id: @user1.id, recipient_id: @user2.id)
      friend_request.update(status: :accepted)
    end
  end

  test "should not create two friends when friend request is rejected" do
    assert_no_difference 'Friend.count' do
      friend_request = FriendRequest.create(sender_id: @user1.id, recipient_id: @user2.id)
      friend_request.update(status: :rejected)
    end
  end
end
