require "test_helper"

class FriendTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @accepted_friend_request = friend_requests(:accepted_one)
  end

  test "should save friend" do
    assert Friend.create(user_id: @accepted_friend_request.sender_id, friend_id: @accepted_friend_request.recipient_id)
  end

  test "should not save friend if user and friend are the same" do
    friend = Friend.new(user_id: @accepted_friend_request.sender_id, friend_id: @accepted_friend_request.sender_id)
    assert_not friend.save
  end
end
