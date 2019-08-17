require 'email_sender'
require 'slack_sender'

class MessagesController < ApplicationController
  protect_from_forgery with: :null_session
  include EmailSender
  include SlackSender
  
  def index
    render json: Message.all.sort_by(&:redis_primary_id).map(&:serialize)
  end

  def create
    # TODO validate request params
    return if params[:text].length > 500

    result = $redis.XADD("messagestream", "*", "text", params[:text], "handle", params[:handle]);
    redis_primary_id, redis_secondary_id = result.split("-")

    user = User.where(handle: params[:handle]).first_or_create
    mentioned_users = parse_for_mentions(params[:text])

    mentioned_users.each do |u|
      if u.email
        send_email(params[:handle], u.email, params[:text])
      end
      if u.slack
        send_slack_message(params[:handle], u.slack, params[:text])
      end
    end
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

  def parse_for_mentions(text) 
    regex = /@\w+/
    handles = text.scan(regex).map{|h| h[1..-1]}
    return User.where(handle: handles)
  end
end