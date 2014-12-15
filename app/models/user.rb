class User < ActiveRecord::Base
  validates :username, :email, :password_digest, presence: true
  validates :password, length: { minimum: 6 }

  attr_reader :password

  def password= secret
    @password = secret
    self.password_digest = BCrypt::Password.create secret
  end

  def is_password? password
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
