class CommentsController < ApplicationController

    def index
        @post = Post.find(params[:post_id])
        @page = params[:page] || 1
        @like = Like.new
        @comments = @post.comments.includes(:user, :likes).order(created_at: :asc).page(@page)
    end

    def new
    end

    def create
        @post = Post.find(params[:post_id])
        @like = Like.new
        @comment = @post.comments.build(comment_params)
        @comment.user_id = current_user.id
        if @comment.save
            ActionCable.server.broadcast(
                "#{current_user.id}_post", 
                {html: render_to_string(partial: 'comments/comment', locals: { comment: @comment, post: @post }),
                post_id: @post.id}
            )
            @post.user.friends.each do |friend|
                ActionCable.server.broadcast(
                    "#{friend.friend_id}_post", 
                    {html: render_to_string(partial: 'comments/comment', locals: { comment: @comment, post: @post }),
                    post_id: @post.id}
                )
            end
            head :ok
        end
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
