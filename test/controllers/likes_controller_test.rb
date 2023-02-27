require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do 
      @user1 = users(:two)
      @post = posts(:one)
      @comment = comments(:one)
      sign_in @user1
    end

    test "should create like for post" do
        assert_difference "Like.count", 1 do
            put like_post_path(@post), params: { like: { status: true, user_id: @user1.id }, user: @user1 }
        end
    end

    test "should create like for comment" do
        assert_difference "Like.count", 1 do
            post post_comment_likes_path(@post, @comment), params: { like: { status: true, user_id: @user1.id }, user_id: @user1.id }
        end
    end
end
