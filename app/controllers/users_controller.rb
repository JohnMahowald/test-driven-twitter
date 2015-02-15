class UsersController < ApplicationController
  before_action :redirect_current_user, only: [:new]
  before_action :ensure_signed_in, only: [:show]
  before_action :ensure_privileges, only: [:show]

  def new
  end

  def create
    user = User.new(user_params)

    if user.save
      login!(user)
      redirect_to user_url(user)
    else
      flash.now[:notice] = user.errors.full_messages
      render :new
    end
  end

  def show
  end
  
  private
  
  def redirect_current_user
    if current_user
      redirect_to user_url current_user
    end
  end

  def ensure_signed_in
    unless current_user
      redirect_to :root
    end
  end

  def ensure_privileges
    unless current_user.id == params[:id].to_i
      redirect_to user_url current_user
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
