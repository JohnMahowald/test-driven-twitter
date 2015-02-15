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

class Tweet < ActiveRecord::Base
  validates :content, :user_id, presence: true
  validates :content, length: { in: 1..140 }
end
