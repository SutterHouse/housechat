class MessagesController < ApplicationController
  protect_from_forgery with: :null_session
  
  def index
    render json: Message.all.sort_by(&:created_at).map(&:serialize)
  end

  def create
    # TODO validate request params

    $redis.XADD("messagestream", "*", "text", params[:text], "handle", params[:handle])

    head :ok
  end
end
