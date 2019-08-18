require 'http'

module SlackSender
  def send_slack_message (sender_name, recipient_endpoint, message)
    HTTP.post(recipient_endpoint, :json => {:text => "[HouseChatLuxe] #{sender_name}: " + message})
  end
end