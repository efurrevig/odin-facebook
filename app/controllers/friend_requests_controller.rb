class FriendRequestsController < ApplicationController
    def index
      @user = User.find(current_user.id)
      @received_requests = @user.received_friend_requests
      @sent_requests = @user.sent_friend_requests
    end

    def create
        @friend_request = FriendRequest.new(friend_request_params)
      
        if @friend_request.save
          flash[:notice] = "Friend request sent successfully!"
        else
          flash[:alert] = @friend_request.errors.full_messages.to_sentence
        end
    end

    def accept_friend_request
        @friend_request = FriendRequest.find(params[:id])
        @friend_request.update(status: 'accepted')
    end
        
    private
        def friend_request_params
            params.require(:friend_request).permit(:sender_id, :recipient_id)
        end
end
