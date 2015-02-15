class Api::FollowersController < ApplicationController
  def create
    @follower = secure_follower
    
    if @follower.save
      render :follower
    else
      render :unprocessable, status: unprocessable_entity
    end
  end

  private

  def follower_params
    params.require(:follower).permit(:user_id, :followee_id)
  end

  def secure_follower
    follower = Follower.new follower_params

    if follower.user_id == current_user.id
      follower
    else
      nil
    end
  end
end
