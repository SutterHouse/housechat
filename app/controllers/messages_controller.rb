class MessagesController < ApplicationController
  protect_from_forgery with: :null_session
  
  def index
    render json: Message.all.sort_by(&:redis_primary_id).map(&:serialize)
  end

  def create
    # TODO validate request params

    result = $redis.XADD("messagestream", "*", "text", params[:text], "handle", params[:handle]);
    redis_primary_id, redis_secondary_id = result.split("-")

    user = User.where(handle: params[:handle]).first_or_create

    Message.create(
        text: params[:text],
        user: user,
        redis_primary_id: redis_primary_id,
        redis_secondary_id: redis_secondary_id
      )

      # broadcast message
      serialized_message = {
        user_handle: params[:handle],
        text: params[:text]
      }
      ActionCable.server.broadcast 'messages_stream_channel', serialized_message.as_json

    head :ok
  end
end
