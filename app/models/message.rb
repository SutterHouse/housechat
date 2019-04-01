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

  def serialize
    hash = self.as_json
    hash[:user_handle] = self.user.handle
    hash
  end
end
