class SessionsController < ApplicationController
  def initialize
    @session_errors = []
  end

  def create
    if valid_session_request? 
      login_and_redirect
    else
      redirect_with_errors
    end
  end

  def destroy
    logout!(@current_user)
    redirect_to "users#new"
  end
  
  private

  def valid_session_request?
    @user = User.find_by_username(session_params[:username])
    validate_username
    validate_password
    @session_errors.empty?
  end

  def login_and_redirect
    login!(@user)
    redirect_to user_url(@user)
  end

  def redirect_with_errors
    flash[:notice] = @session_errors
    redirect_to(:back)
  end

  def validate_username
    if @user
      return true
    else
      @session_errors << "Username does not exist. Please try again."
    end
  end

  def validate_password
    if @user && @user.is_password?(session_params[:password])
      return true
    else
      @session_errors << "Incorrect password. Please try again."
    end
  end

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
