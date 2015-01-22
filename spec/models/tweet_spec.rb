require 'rails_helper'

RSpec.describe Tweet do
  describe "#new" do
    it "can create a tweet" do
      tweet = Tweet.new({
        content: "First Tweet",
      })

      expect(tweet).to be_a Tweet
      expect(tweet.content).to eq "First Tweet"
    end
  end

  describe "#save" do
    it "validates the presence of the content" do
      tweet = Tweet.new

      expect(tweet).to validate_presence_of(:content)
    end
  end
end

