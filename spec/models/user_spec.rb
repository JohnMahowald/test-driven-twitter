# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  email           :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)      not null
#  session_token   :string(255)
#

require 'rails_helper'

RSpec.describe User do
  before :each do
    @user = create :user
  end
  
  describe "#new" do
    it "takes three parameters and returns a User object" do
      expect(@user).to be_a User
    end
  end
  
  describe "#save" do
    it "validates presence of username" do
      expect(@user).to validate_presence_of(:username)
    end
    
    it "validates presence of email" do
      expect(@user).to validate_presence_of(:email)
    end
    
    it "validate presence of password digest" do
      @user = User.new username: "John", email: "John@me.com"

      @user.save

      expect(@user.errors.full_messages).to include(/^Password can't be blank$/)
    end
    
    it "validates the length of password" do
      @user.password = "short"

      @user.save

      expect(@user.errors[:password]).to include(/is too short/)
    end

    describe "authentication" do
      describe "#password=" do
        it "should not store plain text passwords" do
          expect(@user.password_digest).not_to eql("example")
        end
      end

      describe "#is_password?" do
        it "should verify the password is correct" do
          expect(@user.is_password?("example")).to be true 
        end
      end

      describe "User#find_by_credentials" do
        it "should return false if given incorrect params" do
          user = User.find_by_credentials({
            username: @user.username,
            password: "incorrect"
          })

          expect(user).to be(false)
        end

        it "should return the user if given correct params" do
          user = User.find_by_credentials({
            username: @user.username,
            password: @user.password
          })

          expect(user).to eq(@user)
        end
      end

      describe "#reset_session_token!" do
        it "should call the User#generate_session_token method" do
          expect(User).to receive(:generate_session_token)

          @user.reset_session_token!
        end

        it "should change the users session token" do
          token = @user.reset_session_token!

          @user.reset_session_token!

          expect(@user.session_token).not_to eq(token)
        end
      end
    end
  end

  describe "Active Record relations" do
    it "should have many tweets" do
      expect(@user).to have_many :tweets
    end
  end

  describe "#follows" do
  end
end
