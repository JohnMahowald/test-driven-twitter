# == Schema Information
#
# Table name: followers
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  followee_id :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Follower < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with FolloweeExists
  validates :user_id, :followee_id, presence: true
end
