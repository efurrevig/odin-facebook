require "test_helper"

class FriendsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do 
    @user1 = users(:seven)
    @friend1 = friends(:one)
    sign_in @user1
  end

  test "should delete both friends" do
    assert_difference('Friend.count', -2) do
      delete user_friend_path(@user1, @friend1)
    end
  end
end
