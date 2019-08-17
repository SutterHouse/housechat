class MessagesStreamChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages_stream_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    puts "UNSUB DETECTED"
  end
end
