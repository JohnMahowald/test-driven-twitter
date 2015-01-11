class UsersController < ApplicationController
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

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
