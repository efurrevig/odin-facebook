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
            post post_likes_path(@post), params: { like: { status: true, user_id: @user1.id }, user: @user1 }
        end
    end

    test "should create like for comment" do
        assert_difference "Like.count", 1 do
            post post_comment_likes_path(@post, @comment), params: { like: { status: true, user_id: @user1.id }, user_id: @user1.id }
        end
    end

    test "should update like from like to dislike for post" do

    end

    test "should update like from like to dislike for comment" do
    end

    test "should update like from dislike to like for post" do
    end

    test "should update like from dislike to like for comment" do
    end

    # Post like/dislike_count tests
    test "should update like_count for post when like is created" do
    end
    
    test "should update like_count for post when like is updated to true" do
    end

    test "should update like_count for post when like is updated to false" do
    end

    test "should update dislike_count for post when like is updated to true" do
    end

    test "should update dislike_count for post when like is updated to false" do
    end

    test "should update both dislike_count and like_count for post when like is updated to true" do
    end

    test "should update both dislike_count and like_count for post when like is updated to false" do
    end

    # Comment like/dislike_count tests
    test "should update like_count for comment when like is created" do
    end
    
    test "should update like_count for comment when like is updated to true" do
    end

    test "should update like_count for comment when like is updated to false" do
    end

    test "should update dislike_count for comment when like is updated to true" do
    end

    test "should update dislike_count for comment when like is updated to false" do
    end

    test "should update both dislike_count and like_count for comment when like is updated to true" do
    end

    test "should update both dislike_count and like_count for comment when like is updated to false" do
    end
end
