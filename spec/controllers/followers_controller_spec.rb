require 'rails_helper'

RSpec.describe Api::FollowersController, type: :controller do
  render_views

  before(:each) do
    @user = create :user 
    @followee = create :followee

    expect(@controller).to receive(:current_user).and_return @user
  end

  describe "#create" do
    context "when the followee exists" do
      it "can create a new follower" do
        post :create, follower: { user_id: @user.id, followee_id: @followee.id }, format: :json

        expect(response.status).to be 200
        expect(response).to match_response_schema "follower"
      end
    end

    context "when the followee doesn't exist" do
      it "cannot create a new follower" do
      end
    end
  end

  describe "#destroy" do
    context "when a follower exists" do
      it "can destroy an existing follower" do
      end
      
      it "cannot destroy another users followers" do
      end
    end

    context "when a follower doesn't exist" do
      it "cannot destroy a follower that doesn't exist" do
      end
    end
  end
end
