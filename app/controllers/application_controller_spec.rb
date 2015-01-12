require 'rails_helper' 

RSpec.describe ApplicationController, type: :controller do
  before(:each) do
    controller do ; end
    @user = create :user
  end
      
  describe '#login' do

    it "calls the users reset_session_token! method" do
      expect(@user).to receive(:reset_session_token!)

      controller.login!(@user)
    end

    it "sets the current user to the logged in user" do
      expect(controller.current_user).to be_nil

      controller.login!(@user)

      expect(controller.current_user).to eq(@user)
    end

    it "sets the session token to the users session token" do
      controller.login!(@user)

      expect(session[:token]).to eq(@user.session_token)
    end
  end

  describe '#current_user' do
    it 'returns nil if there is no session_token' do
      expect(controller.current_user).to be_nil
    end

    it 'identifies the current user by session token' do
      controller.login!(@user)

      expect(User).to receive(:find_by_session_token)

      controller.current_user
    end
  end
end
