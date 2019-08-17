require 'http'

module SlackSender
  def send_slack_message (sender_name, recipient_endpoint, message)
    HTTP.post(recipient_endpoint, :json => {:text => "You have received a message from #{sender_name}!"})
    HTTP.post(recipient_endpoint, :json => {:text => message})
  end
end