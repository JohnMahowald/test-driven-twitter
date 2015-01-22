require 'rails_helper'

RSpec.describe Tweet do
  describe "#new" do
    it "can create a tweet" do
      tweet = Tweet.new({
        content: "First Tweet",
      })

      expect(tweet).to be_a Tweet
      expect(tweet.content).to be "First Tweet"
    end
  end
end

