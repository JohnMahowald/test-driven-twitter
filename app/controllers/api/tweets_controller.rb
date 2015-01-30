class Api::TweetsController < ApplicationController
  def create
    @tweet = Tweet.new(tweet_params)

    if @tweet.save
      render json: @tweet
    else
      render json: { errors: @tweet.errors.full_messages } , status: :unprocessable_entity
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
