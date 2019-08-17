require 'twilio-ruby'

module SmsSender
  @@twilio = Twilio::REST::Client.new(
    ENV['TWILIO_ACCOUNT_SID'],
    ENV['TWILIO_AUTH_TOKEN']
  )
  def send_sms(sender_name, recipient_phone, message)
    text = "[HouseChatLuxe] #{sender_name}: #{message}"
    @@twilio.messages.create(
      from: ENV['TWILIO_PHONE_NUMBER'],
      to: recipient_phone,
      body: text
    )
  end
end