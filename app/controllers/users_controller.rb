class UsersController < ApplicationController
  before_action :ensure_signed_in, only: [:show]
  before_action :redirect_current_user

  def new
  end

  def create
    user = User.new(user_params)

    if user.save
      redirect_to user_url(@user)
    else
      flash.now[:notice] = user.errors.full_messages
      render :new
    end
  end

  def show
  end
  
  private
  
  def redirect_current_user
    render :show if current_user
  end

  def ensure_signed_in
    unless current_user
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
