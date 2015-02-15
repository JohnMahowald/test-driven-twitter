class CreateFollowersTable < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.integer :user_id, null: false
      t.integer :followee_id, null: false

      t.timestamps
    end
  end
end
