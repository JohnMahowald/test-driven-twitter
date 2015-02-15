class AddUserIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :user_id, :integer
    change_column :tweets, :user_id, :integer, null: false
  end
end
