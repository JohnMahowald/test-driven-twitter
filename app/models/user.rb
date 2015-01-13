class User < ActiveRecord::Base
  validates :username, :email, presence: true
  validates :password_digest, presence: { message: "can't be blank" } 
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password

  def User.find_by_credentials(params)
    user = User.find_by_username(params[:username])
    User.ensure_valid_user_and_password(user, params[:password])
  end

  def User.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end
    
  def password=(secret)
    return if secret == ""
    @password = secret
    self.password_digest = BCrypt::Password.create(secret)
  end

  def is_password? password
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  private

  def User.ensure_valid_user_and_password(user, password)
    if user && user.is_password?(password)
      return user
    else
      return false
    end
  end
end
