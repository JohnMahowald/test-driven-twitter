# == Schema Information
#
# Table name: followers
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  follower_id :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe Follower do
  before(:each) { @follower = Follower.new }

  it "validates the presence of a user_id" do
    expect(@follower).to validate_presence_of :user_id
  end

  it "validates the presence of a follower_id" do
    expect(@follower).to validate_presence_of :follower_id
  end
end
