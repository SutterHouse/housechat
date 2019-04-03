class AddRedisIdToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :redis_uid, :string
  end
end
