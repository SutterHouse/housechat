require 'email_sender'
require 'slack_sender'
require 'sms_sender'
require 'messages_controller_helper'

class MessagesController < ApplicationController
  protect_from_forgery with: :null_session
  include EmailSender
  include SlackSender
  include SmsSender
  include MessagesControllerHelper
  
  def index
    render json: Message.all.sort_by(&:redis_primary_id).map(&:serialize)
  end

  def create
    return if !isValidBrowser(request.headers)
    return if !isValidHandle(params[:handle])
    return if !isValidMessage(params[:text])

    result = $redis.XADD("messagestream", "*", "text", params[:text], "handle", params[:handle]);
    redis_primary_id, redis_secondary_id = result.split("-")

    user = User.where(handle: params[:handle]).first_or_create
    mentioned_users = parse_for_mentions(params[:text])

    # create message
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

    # handle integrated notifications
    mentioned_users.each do |u|
      if u.email
        send_email(params[:handle], u.email, params[:text])
      end
      if u.slack
        send_slack_message(params[:handle], u.slack, params[:text])
      end
      if u.phone
        send_sms(params[:handle], u.phone, params[:text])
      end
    end

    head :ok
  end

  def parse_for_mentions(text) 
    regex = /@\w+/
    handles = text.scan(regex).map{|h| h[1..-1]}
    return User.where(handle: handles)
  end
end