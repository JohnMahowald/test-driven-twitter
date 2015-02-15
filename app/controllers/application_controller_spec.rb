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

  describe '#logout!' do
    it "resets the user's session token" do
      expect(@user).to receive(:reset_session_token!)

      controller.logout!(@user)
    end

    it "resets the session token to be nil" do
      session[:token] = "nothing important"

      controller.logout!(@user)
      
      expect(session[:token]).to be_nil
    end
  end

  describe '#current_user' do
    context "when no user is signed in" do

      it 'returns nil if there is no session_token' do
        session[:token] = nil

        expect(controller.current_user).to be_nil
      end
    end

    context "when a user is signed in" do

      before(:each) do
        @user.session_token = "session"
        @user.save!

        session[:token] = @user.session_token
      end

      it 'identifies the current user by session token' do
        expect(User).to receive(:find_by_session_token).with("session").and_return @user

        expect(controller.current_user).to eq @user
      end

      it 'stores the current_user in a local variable' do
        expect(User).to receive(:find_by_session_token).with("session").and_return @user

        expect(controller.current_user).to eq @user

        expect(User).not_to receive(:find_by_session_token)

        expect(controller.current_user).to eq @user
      end
    end
  end
end
