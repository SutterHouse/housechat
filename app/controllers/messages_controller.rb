class MessagesController < ApplicationController
  def index
    render json: Message.all.sort_by(&:created_at).map(&:as_json)
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
