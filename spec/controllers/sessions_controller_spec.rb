require 'rails_helper'

RSpec.describe SessionsController do
  before(:each) do
    @user = create :user
  end

  describe 'Session#create' do
    before(:each) do
      request.env['HTTP_REFERER'] = '/'
    end

    context "user enters invalid credentials" do
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
    end

    context "when user enters correct credentials" do
      before(:each) do
        def sign_in_user
          post 'create', session: {
            username: @user.username,
            password: @user.password
          }
        end
      end
      it "logs in a user" do
        expect(@controller).to receive(:login!)

        sign_in_user
      end

      it 'redirects the user to the user_url' do
        sign_in_user

        expect(response).to redirect_to(user_url(@user))
      end

      it 'sets the current_user to the user' do
        sign_in_user

        expect(@controller.current_user).to eq(@user)
      end
    end
  end

end
