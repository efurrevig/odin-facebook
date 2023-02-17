class FriendRequestsController < ApplicationController

    def create
        @friend_request = FriendRequest.new(friend_request_params)
        @friend_request.save
    end
    private
        def friend_request_params
            params.require(:friend_request).permit(:sender_id, :recipient_id)
        end
end
