class AddRedisIdsToMessages < ActiveRecord::Migration[5.2]
  def change
    remove_column :messages, :redis_uid

    add_column :messages, :redis_primary_id, :integer
    add_column :messages, :redis_secondary_id, :integer
  end
end
