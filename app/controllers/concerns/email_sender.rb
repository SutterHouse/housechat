# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
include SendGrid

module EmailSender
  def send_email(sender_name, recipient_email, message)
    from = Email.new(email: 'housechatluxe@gmail.com')
    to = Email.new(email: recipient_email)
    subject = "You have a new message from #{sender_name}!"
    content = Content.new(type: 'text/plain', value: message)
    mail = Mail.new(from, subject, to, content)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end
end