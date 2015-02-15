# == Schema Information
#
# Table name: tweets
#
#  id         :integer          not null, primary key
#  content    :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer          not null
#

require 'rails_helper'

RSpec.describe Tweet do
  before(:each) do
    @tweet = Tweet.new
  end
  describe "#new" do
    it "can create a tweet" do
      @tweet.content = "First Tweet"

      expect(@tweet).to be_a Tweet
      expect(@tweet.content).to eq "First Tweet"
    end
  end

  describe "#save" do
    it "validates the presence of the content" do
      expect(@tweet).to validate_presence_of(:content)
    end

    it "validates the content 140 characters max" do
      @tweet.content = 160.times.inject("") { |str, i| str + "a" }

      @tweet.save

      expect(@tweet.errors.full_messages).to include "Content is too long (maximum is 140 characters)"
    end

    it "validates the content is at least 1 character" do
      @tweet.content = ""

      @tweet.save

      expect(@tweet.errors.full_messages).to include "Content is too short (minimum is 1 characters)"
    end
  end
end

