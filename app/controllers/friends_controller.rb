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
        
        respond_to do |format|
            if @friend.destroy && @other_friend.destroy
                format.html { redirect_to user_friends_path(current_user.id), notice: 'Friend was successfully removed.' }
                format.json { render json:, status: :ok}
            else
                format.html { redirect_to user_friends_path(current_user.id), status: :unprocessable_entity }
                format.json { render json:, status: :unprocessable_entity }
            end
        end
    end

    private
        def friend_params
            params.require(:friend).permit(:user_id, :friend_id, :friend_request_id)
        end
end
