require "test_helper"

class FriendTest < ActiveSupport::TestCase
  
  setup do
    @accepted_friend_request = friend_requests(:accepted_one)
    @rejected_friend_request = friend_requests(:rejected_one)
    @pending_friend_request = friend_requests(:pending_one)
    @already_friends_request = friend_requests(:already_friends_one)
    @friend = friends(:one)
  end

  test "should save friend" do
    friend = Friend.new(user_id: @accepted_friend_request.sender_id, friend_id: @accepted_friend_request.recipient_id, friend_request_id: @accepted_friend_request.id)
    assert friend.save
  end

  test "should not save friend if user and friend are the same" do
    friend = Friend.new(user_id: @accepted_friend_request.sender_id, friend_id: @accepted_friend_request.sender_id, friend_request_id: @accepted_friend_request.id)
    assert_not friend.save
  end
  
  test "should not save friend if already friends" do
    @friend = friends(:one)
    friend = Friend.new(user_id: @already_friends_request.sender_id, friend_id: @already_friends_request.recipient_id, friend_request_id: @already_friends_request.id)
    assert_not friend.save
  end

  test "should not save friend if friend request is rejected" do
    friend = Friend.new(user_id: @rejected_friend_request.sender_id, friend_id: @rejected_friend_request.recipient_id, friend_request_id: @rejected_friend_request.id)
    assert_not friend.save
  end

  test "should not save friend if friend request is pending" do
    friend = Friend.new(user_id: @pending_friend_request.sender_id, friend_id: @pending_friend_request.recipient_id, friend_request_id: @pending_friend_request.id)
    assert_not friend.save
  end

  
end
