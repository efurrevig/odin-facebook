require "test_helper"

class FriendRequestsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do 
    @user1 = users(:one)
    @user2 = users(:two)
    sign_in @user1
  end

  test "should create friend request" do
    post user_friend_requests_url(user_id: @user1.id, friend_request: { sender_id: @user1.id, recipient_id: @user2.id })
    assert_response :success
  end
end
