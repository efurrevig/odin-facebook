class FriendsController < ApplicationController
    def index
        @friends = current_user.friends
    end

    def create
        @friend = Friend.new(friend_params)

        if @friend.save
            flash[:notice] = "Friend added"
        else
            flash[:alert] = @friend.errors.full_messages.to_sentence
        end
    end

    def destroy
        @friend = Friend.find(params[:id])
        @other_friend = Friend.find_by(user_id: @friend.friend_id, friend_id: @friend.user_id)
        # other friend
        if @friend.destroy && @other_friend.destroy
            flash[:notice] = "Friend removed"
        else
            flash[:alert] = @friend.errors.full_messages.to_sentence
        end
    end

    private
        def friend_params
            params.require(:friend).permit(:user_id, :friend_id, :friend_request_id)
        end
end
