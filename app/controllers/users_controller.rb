class UsersController < ApplicationController
  def index
    @posts = current_user.posts.order(created_at: :desc).all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).all
  end

  def edit
    @user = current_user
  end

  private
    def user_params
    end

    def set_user
      # may not be neccessary
    end
end
