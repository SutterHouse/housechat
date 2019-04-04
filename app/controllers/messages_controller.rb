class MessagesController < ApplicationController
  protect_from_forgery with: :null_session
  
  def index
    messages = $redis.XREVRANGE("messagestream", "+", "-", "COUNT", 100)
    parsed_messages = messages.map {|id, message| {user_handle: message[3], text: message[1]}}
    render json: parsed_messages.to_json
  end

  def create
    # TODO validate request params

    $redis.XADD("messagestream", "*", "text", params[:text], "handle", params[:handle])

    head :ok
  end
end
