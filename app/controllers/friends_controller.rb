class FriendsController < ApplicationController
    def index
    end

    def create
        @friend = Friend.new(friend_params)

        if @friend.save
            flash[:notice] = "Friend added"
        else
            flash[:alert] = @friend.errors.full_messages.to_sentence
        end
    end

    private
        def friend_params
            params.require(:friend).permit(:user_id, :friend_id, :friend_request_id)
        end
end