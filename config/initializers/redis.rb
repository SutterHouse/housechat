require "redis"

$redis = Redis.new

$redis.flushall

messages = Message.order(:redis_primary_id, :redis_secondary_id).limit(100)
parsed_messages = messages.each do |msg|
  next if msg.redis_primary_id.blank? || msg.redis_secondary_id.blank?
  $redis.XADD(
    "messagestream",
    "#{msg.redis_primary_id}-#{msg.redis_secondary_id}",
    "handle",
    msg.user.handle,
    "text",
    msg.text
  )
end