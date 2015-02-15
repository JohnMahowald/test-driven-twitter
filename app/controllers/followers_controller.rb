class FollowersController < ApplicationController
  def create
  end

  private

  def follower_params
    params.require(:follower).permit(:user_id, :followee_id)
  end
end
