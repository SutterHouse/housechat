class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :handle
      t.timestamps
    end

    create_table :messages do |t|
      t.string :text
      t.references :user
      t.timestamps
    end

  end
end
