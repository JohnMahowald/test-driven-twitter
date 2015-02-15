class FolloweeExists < ActiveModel::Validator
  def validate(record)
    unless User.exists?({ id: record.followee_id })
      record.errors[:exists] << "You are not able to follow a user who does not exist"
    end
  end
end
