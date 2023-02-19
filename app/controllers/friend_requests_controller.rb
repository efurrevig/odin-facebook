class FriendRequestsController < ApplicationController
    before_action :friend_request_uniqueness, only: [:create]

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
        if @friend_request.update(status: :accepted)
            flash[:notice] = "Friend request accepted"
        else
            flash[:notice] = @friend_request.errors.full_messages.to_sentence
        end
    end

    def decline_friend_request
        @friend_request = FriendRequest.find(params[:id])
        if @friend_request.update(status: :rejected)
            flash[:notice] = "Friend request declined"
        else
            flash[:notice] = @friend_request.errors.full_messages.to_sentence
        end
    end
        
    private
        def friend_request_params
            params.require(:friend_request).permit(:sender_id, :recipient_id)
        end

        def friend_request_uniqueness
          sender = params[:sender_id]
          recipient = params[:recipient_id]
          if FriendRequest.where(sender: sender, recipient: recipient).exists?
              errors.add(:base, 'Friend request already exists')
          end
        end
end
