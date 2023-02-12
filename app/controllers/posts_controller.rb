class PostsController < ApplicationController
  def index
    @posts = Post.includes(:comments).all
    @post = Post.new
    @comment = Comment.new
    @like = Like.new
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
end
