class Api::TweetsController < ApplicationController
  def create
    @tweet = Tweet.new(tweet_params)

    if @tweet.save
      render :tweet
    else
      render :errors, status: :unprocessable_entity
    end
  end

  def update
    @tweet = Tweet.find(params[:id])

    if @tweet.update_attributes(tweet_params)
      render :tweet
    else
      render :errors, status: :unprocessable_entity
    end
  end

  def show
    @tweet = Tweet.find_by_id params[:id]

    if @tweet
      render :tweet
    else
      render :not_found, status: :unprocessable_entity
    end
  end

  def destroy
    @tweet = Tweet.find_by_id params[:id]

    destroy_or_return @tweet
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content, :user_id)
  end

  def destroy_or_return tweet
    if tweet && (current_user.id == tweet.user_id)
      tweet.destroy!
      render :tweet
    else
      render :unprocessable, status: :unprocessable_entity
    end
  end
end
