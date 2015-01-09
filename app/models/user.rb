class User < ActiveRecord::Base
  validates :username, :email, :password, presence: true
  validates :password_digest, presence: { message: "Password can't be blank" } 
  validates :password, length: { minimum: 6, allow_nil: true, allow_blank: true }

  attr_reader :password

  def password=(secret)
    @password = secret
    self.password_digest = BCrypt::Password.create(secret)
  end

  def is_password? password
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
