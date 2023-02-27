class LikesController < ApplicationController
  def create
    if params.include?(:comment_id)
      @comment = Comment.find(params[:comment_id])
      @like = @comment.likes.build(likes_params)
      @like.user_id = current_user.id
      @like.save
    else
      @post = Post.find(params[:post_id])
      @like = @post.likes.create(likes_params, user_id: current_user.id)
    end
  end

  def update
  end

  def destroy
  end

  private
    def likes_params
      params.require(:like).permit(:status, :user_id, :post_id, :comment_id)
    end
end
