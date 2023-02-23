class PostsController < ApplicationController
  def index
    @posts = Post.includes(:comments).order(created_at: :desc).all
    @friends = current_user.friends
    @post = Post.new
    @comment = Comment.new
    @like = Like.new
    @friend_request = FriendRequest.new
  end

  def like_post
    @post = Post.find(params[:id])
    if @post.liked?(current_user)
      like = @post.likes.find{|like| like.user_id == current_user.id}
      like.status.to_s == params[:like][:status] ? like.destroy : like.update(status: params[:like][:status])
    else
      Like.create(like_params.merge(user_id: current_user.id, post_id: @post.id))
    end
  end

  def show
  end

  def new
  end

  def create
    @post = current_user.posts.build(post_params)

    @post.save
    ActionCable.server.broadcast('post', @post.as_json(include: :user))
  end

  def edit
  end

  def destroy
  end

  private

    def post_params
      params.require(:post).permit(:body)
    end

    def like_params
      params.require(:like).permit(:status, :user_id, :post_id, :comment_id)
    end
end
