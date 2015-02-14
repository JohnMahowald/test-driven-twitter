class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  attr_reader :current_user

  def login!(user)
    session[:token] = user.reset_session_token!
    @current_user = user
  end

  def logout!(user)
    user.reset_session_token!
    session[:token] = nil
  end

  def current_user
    unless session[:token]
      return nil
    end

    @current_user ||= User.find_by_session_token(session[:token])
  end
end
