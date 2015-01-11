require 'rails_helper'

RSpec.describe UsersController do
  describe "GET #new" do
    it "redirects the user to the new view" do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "when password is invalid" do
      before(:each) { @user = create :user } 

      it "renders page with length validation" do
        post 'create', user: { 
          username: @user.username, 
          email: @user.email,
          password: "short"
        } 

        expect(response).to render_template(:new)
        expect(flash[:notice]).to include(/^Password is too short \(minimum is 6 characters\)$/) 
      end

      it "renders page with presence validation" do
        post 'create', user: {
          username: @user.username,
          email: @user.email,
          password: ""
        }

        expect(response).to render_template(:new)
        expect(flash[:notice]).to include(/^Password can't be blank$/)
      end
    end
  end
end
