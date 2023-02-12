class LikesController < ApplicationController
  def create
    if params.include?(:post_id)
      @parent = Post.find(params[:post_id])
      @like = @parent.likes.build(likes_params.merge(user_id: current_user.id))
    elsif params.include?(:comment_id)
      @parent = Comment.find(params[:comment_id])
      @like = @parent.likes.build(likes_params.merge(user_id: current_user.id))
    end

    if @like.save!
      if @like.status
        @parent.increment!(:like_count)
      else  
        @parent.decrement!(:dislike_count)
      end
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
