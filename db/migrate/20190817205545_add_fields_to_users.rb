class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email, :string
    add_column :users, :phone, :string
    add_column :users, :slack, :string
  end
end
