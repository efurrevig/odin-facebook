class UserController < ApplicationController
  def index
    @posts = current_user.posts
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
