require "test_helper"

class LikeTest < ActiveSupport::TestCase
  setup do
    @post = posts(:one)
    @comment = comments(:one)
    @user = users(:two)
  end

  test "should create like for comment" do
    assert_difference "Like.count", 1 do
      @comment.likes.create(user_id: @user.id, status: true)
    end
  end

  test "should create like for post" do
    assert_difference "Like.count", 1 do
      @post.likes.create(user_id: @user.id, status: true)
    end
  end

  test "should increase likes count for post" do
    assert_difference "@post.like_count", 1 do
      @post.likes.create(user_id: @user.id, status: true)
    end
  end
end
