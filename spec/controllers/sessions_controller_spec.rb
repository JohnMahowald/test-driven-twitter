require 'rails_helper'

RSpec.describe SessionsController do
  before(:each) do
    @user = create :user
    @user.save
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
        def make_post_request
          post 'create', session: {
            username: @user.username,
            password: @user.password
          }
        end
      end
      it "logs in a user" do
        expect(@controller).to receive(:login!)

        make_post_request
      end

      it 'redirects the user to the user_url' do
        make_post_request 

        expect(response).to redirect_to(user_url(@user))
      end
    end
  end
end
