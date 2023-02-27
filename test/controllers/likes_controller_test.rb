require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    setup do 
      @user1 = users(:two)
      @post = posts(:one)
      @post2 = posts(:two)
      @like2 = likes(:two)
      @like3 = likes(:three)
      #comment likes
      @like4 = likes(:four)
      @like5 = likes(:five)

      @comment = comments(:one)
      @comment2 = comments(:two)
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

    test "should update Like from true to false for post" do
        #like2, post2
        assert_changes -> { Like.find(@like2.id).status }, from: true, to: false do
            patch post_like_path(@post2, @like2), params: { like: { status: false, user_id: @user1.id }, user_id: @user1.id }
            #puts flash[:alert]
        end

    end

    test "should update Like from false to true for post" do
        assert_changes -> { Like.find(@like3.id).status }, from: false, to: true do
            patch post_like_path(@post2, @like3), params: { like: { status: true, user_id: @user1.id }, user_id: @user1.id }
            #puts flash[:alert]
        end

    end

    test "should update Like from true to false for comment" do
        assert_changes -> { Like.find(@like4.id).status }, from: true, to: false do
            patch post_comment_like_path(@post, @comment, @like4), params: { like: { status: false, user_id: @user1.id }, user_id: @user1.id }
        end
    end

    test "should update Like from false to true for comment" do
        assert_changes -> { Like.find(@like5.id).status }, from: false, to: true do
            patch post_comment_like_path(@post, @comment, @like5), params: { like: { status: true, user_id: @user1.id }, user_id: @user1.id }
        end
    end

    # Post like/dislike_count tests
    test "should update like_count for post when like is created as true" do
        assert_difference "Post.find(@post.id).like_count", 1 do
            post post_likes_path(@post), params: { like: { status: true, user_id: @user1.id }, user: @user1 }
        end
    end
    
    test "should update dislike_count for post when like is created as false" do
        assert_difference "Post.find(@post.id).dislike_count", 1 do
            post post_likes_path(@post), params: { like: { status: false, user_id: @user1.id }, user: @user1 }
        end
    end

    test "should update both dislike_count and like_count for post when like is updated to true" do
        assert_difference({'Post.find(@post2.id).like_count' => 1, 'Post.find(@post2.id).dislike_count' => -1}) do
            patch post_like_path(@post2, @like2), params: { like: { status: true, user_id: @user1.id }, user_id: @user1.id }
        end
    end

    test "should update both dislike_count and like_count for post when like is updated to false" do
        assert_difference({'Post.find(@post2.id).like_count' => -1, 'Post.find(@post2.id).dislike_count' => 1}) do
            patch post_like_path(@post2, @like3), params: { like: { status: false, user_id: @user1.id }, user_id: @user1.id }
        end
    end

    # Comment like/dislike_count tests
    test "should update like_count for comment when like is created" do
        assert_difference "Comment.find(@comment.id).like_count", 1 do
            post post_comment_likes_path(@post, @comment), params: { like: { status: true, user_id: @user1.id }, user_id: @user1.id }
        end
    end
    
    test "should update like_count for comment when like is updated to true" do
        assert_difference "Comment.find(@comment2.id).like_count", 1 do
            patch post_comment_like_path(@post, @comment2, @like5), params: { like: { status: true, user_id: @user1.id }, user_id: @user1.id }
        end
    end

    test "should update like_count for comment when like is updated to false" do
        assert_difference "Comment.find(@comment2.id).like_count", -1 do
            patch post_comment_like_path(@post, @comment2, @like4), params: { like: { status: false, user_id: @user1.id }, user_id: @user1.id }
        end
    end

    test "should update dislike_count for comment when like is updated to true" do
        assert_difference "Comment.find(@comment2.id).dislike_count", -1 do
            patch post_comment_like_path(@post, @comment2, @like5), params: { like: { status: true, user_id: @user1.id }, user_id: @user1.id }
        end
    end

    test "should update dislike_count for comment when like is updated to false" do
        assert_difference "Comment.find(@comment2.id).dislike_count", 1 do
            patch post_comment_like_path(@post, @comment2, @like4), params: { like: { status: false, user_id: @user1.id }, user_id: @user1.id }
        end
    end

    test "should update both dislike_count and like_count for comment when like is updated to true" do
        assert_difference({'Comment.find(@comment2.id).like_count' => 1, 'Comment.find(@comment2.id).dislike_count' => -1}) do
            patch post_comment_like_path(@post, @comment2, @like5), params: { like: { status: true, user_id: @user1.id }, user_id: @user1.id }
        end
    end

    test "should update both dislike_count and like_count for comment when like is updated to false" do
        assert_difference({'Comment.find(@comment2.id).like_count' => -1, 'Comment.find(@comment2.id).dislike_count' => 1}) do
            patch post_comment_like_path(@post, @comment2, @like4), params: { like: { status: false, user_id: @user1.id }, user_id: @user1.id }
        end
    end
end
