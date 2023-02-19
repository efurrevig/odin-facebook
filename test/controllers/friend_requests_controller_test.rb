require "test_helper"

class FriendRequestsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do 
    @user1 = users(:one)
    @user2 = users(:two)
    sign_in @user1
  end

  test "should get index" do
    get user_friend_requests_path(@user1.id)
    assert_response :success
  end

  test "should accept friend request" do
    @friend_request = friend_requests(:pending_one)
    put accept_friend_request_path(@user1.id, @friend_request.id)
    @friend_request.reload
    assert_equal "accepted", @friend_request.status
  end

  test "should decline friend request" do
    @friend_request = friend_requests(:pending_one)
    delete decline_friend_request_path(@user1.id, @friend_request.id)
    @friend_request.reload
    assert_equal "rejected", @friend_request.status
  end
  
  test "should create friend request" do
    assert_difference('FriendRequest.count') do
      post user_friend_requests_url(user_id: @user1.id, 
                                    friend_request: { sender_id: @user1.id, recipient_id: @user2.id })
    end
  end

  test "should not create friend request if friend request already exists" do
    assert_no_difference('FriendRequest.count') do
      post user_friend_requests_url(user_id: @user1.id,
                                    friend_request: { sender_id: 200, recipient_id: 201 })
    end
  end

  test "should redirect to friend request index if html request" do
    post user_friend_requests_url(user_id: @user1.id, 
                                  friend_request: { sender_id: @user1.id, recipient_id: @user2.id }), xhr: false
    assert_equal "Friend request sent successfully!", flash[:notice]
  end

  test "should return flash 'cant be the same as friend' if friend request already exists" do 
    post user_friend_requests_url(user_id: @user1.id,
                                  friend_request: { sender_id: @user1.id, recipient_id: @user1.id }), xhr: true
    assert_equal "Sender can't be the same as recipient", flash[:alert]
  end
end
