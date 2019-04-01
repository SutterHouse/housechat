class MessagesController < ApplicationController
  protect_from_forgery with: :null_session
  
  def index
    render json: Message.all.sort_by(&:created_at).map(&:serialize)
  end

  def create
    # TODO validate request params

    user = User.where(handle: params[:handle]).first_or_create
    Message.create(
      text: params[:text],
      user: user
    )

    head :ok
  end
end
