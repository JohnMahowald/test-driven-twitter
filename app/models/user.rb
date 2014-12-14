class User < ActiveRecord::Base
  validates :username, :email, :password, presence: true
  validates :password, length: { minimum: 6 }
end