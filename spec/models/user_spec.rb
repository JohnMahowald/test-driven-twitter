require 'rails_helper'

RSpec.describe User do
  before :each do
    @user = create :user
  end
  
  describe "#new" do
    it "takes three arameters and returns a User object" do
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

      expect(@user.errors[:password_digest]).to include(/^Password can't be blank$/)
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
        it "it should verify the password is correct" do
          expect(@user.is_password?("example")).to be true 
        end
      end
    end
  end
end
