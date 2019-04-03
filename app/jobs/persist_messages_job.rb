class PersistMessagesJob < ActiveJob::Base
  def perform
    last_primary_id = Message.maximum(:redis_primary_id) || 0
    last_secondary_id = Message.where(redis_primary_id: last_primary_id).maximum(:redis_secondary_id) || 0
    last_id = "#{last_primary_id}-#{last_secondary_id}"

    messages = $redis.XREAD("COUNT", 100, "STREAMS", "messagestream", last_id)[0][1]
    puts "#{messages}"
    messages.each do |id, message|
      puts "message is #{message}"
      redis_primary_id, redis_secondary_id = id.split("-")
      user = User.where(handle: message[3]).first_or_create
      Message.create(
        text: message[1],
        user: user,
        redis_primary_id: redis_primary_id,
        redis_secondary_id: redis_secondary_id
      )
    end

    # TODO: Q_Q why doesn't this work?
    # PersistMessagesJob.set(wait: 10.seconds).perform_later
  end
end



