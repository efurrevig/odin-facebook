class PostChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "post"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    data['user'] = current_user
    ActionCable.server.broadcast('post', data)
  end
end
