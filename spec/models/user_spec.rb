require 'rails_helper'

RSpec.describe User do
  before :each do
    @user = User.new username: "John", email: "John@me.com", password: "Sample"
  end
  
  describe "#new" do
    it "takes three arameters and returns a User object" do
      expect(@user).to be_a User
    end
  end
  
  describe "#save" do
    it "validates presence of username" do
      @user.username = ""
      @user.save
      
      expect(@user.errors[:username]).to include("can't be blank")
    end
    
    it "validates presence of email" do
      @user.email = ""
      @user.save
      
      expect(@user.errors[:email]).to include("can't be blank")
    end
    
    it "validates presence of password" do
      @user.password = ""
      @user.save
      
      expect(@user.errors[:password]).to include("can't be blank")
    end
    
    it "validates the length of password" do
      @user.password = "short"
      @user.save
      
      expect(@user.errors[:password][0]).to eq("is too short (minimum is 6 characters)")
    end
  end
  
  describe "#save" do
    it "validates presnece of username" do
      user = User.new
      user.save
      
      expect(user.errors).to_not be_empty?
    end
  end
  
end