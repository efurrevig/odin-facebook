class CommentsController < ApplicationController

    def new
    end

    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params)
        @comment.user_id = current_user.id
        @comment.save
    end

    def like_comment
        @comment = Comment.find(params[:id])
        if @comment.liked?(current_user)
          like = @comment.likes.find{|like| like.user_id == current_user.id}
          like.status.to_s == params[:like][:status] ? like.destroy : like.update(status: params[:like][:status])
        else
          Like.create(like_params.merge(user_id: current_user.id, comment_id: @comment.id))
        end
    end

    private

        def comment_params
            params.require(:comment).permit(:body, :user_id, :post_id)
        end

        def like_params
            params.require(:like).permit(:status, :user_id, :post_id, :comment_id)
        end
end
