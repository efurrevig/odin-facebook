class FriendRequestsController < ApplicationController

    def create
        @friend_request = FriendRequest.new(friend_request_params)
        @user = User.find(params[:user_id])
      
        respond_to do |format|
          if @friend_request.save
            format.html { render json: { success: true, notice: 'Friend request sent.' } }
            format.json { render json: { success: true, notice: 'Friend request sent.' } }
          else
            format.html { render json: { success: false, alert: @friend_request.errors.full_messages } }
            format.json { render json: { success: false, alert: @friend_request.errors.full_messages } }
          end
        end
    end

    private
        def friend_request_params
            params.require(:friend_request).permit(:sender_id, :recipient_id)
        end
end
