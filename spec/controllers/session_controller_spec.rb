require 'rails_helper'

RSpec.describe SessionController do
  before(:each) do
    @user = create :user
    @user.save
  end

  describe 'Session#create' do
    before(:each) do
      request.env['HTTP_REFERER'] = '/'
    end

    context "when user is not yet signed in" do
      it 'validates the username exists' do
        post 'create', session: {
          username: 'fake_user'
        }

        expect(response).to redirect_to("/");
        expect(flash[:notice]).to include(/^Username does not exist. Please try again.$/)
      end

      it 'identifies an incorrect password' do
        post 'create', session: {
          username: @user.username,
          password: "incorrect"
        } 

        expect(flash[:notice]).to include(/^Incorrect password. Please try again.$/);
      end

      it 'logs in a user if username and password are correct' do
        post 'create', session: {
          username: @user.username,
          password: @user.password
        }

        expect(response).to redirect_to user_url(@user)
      end
    end
  end
end
