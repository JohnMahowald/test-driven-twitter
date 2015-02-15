class CreateFollowersTable < ActiveRecord::Migration
  def change
    create_table :followers_tables do |t|
      t.integer :user_id, null: false
      t.integer :follower_id, null: false

      t.timestamps
    end
  end
end
