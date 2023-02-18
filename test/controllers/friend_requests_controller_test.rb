require "test_helper"

class FriendRequestsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do 
    @user1 = users(:one)
    @user2 = users(:two)
    sign_in @user1
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
    assert_response :redirect
    assert_redirected_to user_friend_requests_url(user_id: @user1.id)
  end
end
