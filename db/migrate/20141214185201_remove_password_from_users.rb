class RemovePasswordFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :password
  end

  def change
    add_column :users, :password_digest, :string
    change_column_null :users, :password_digest, false
  end
end
