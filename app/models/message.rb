# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  text       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Message < ActiveRecord::Base
  belongs_to :user

  def as_json
    hash = self.as_json
    hash[:handle] = self.user.handle
    handle
  end
end
