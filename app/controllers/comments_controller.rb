class CommentsController < ApplicationController

    def new
    end

    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params)
        @comment.user_id = current_user.id
        @comment.creator = current_user.name
        @comment.save
    end


    private

    def comment_params
        params.require(:comment).permit(:body, :user_id, :post_id)
    end
end
