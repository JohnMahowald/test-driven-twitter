require 'rails_helper'
require 'byebug'

RSpec.describe Api::TweetsController, type: :controller do
  render_views

  describe "POST #create" do
    context "when content is not present" do
      it "renders errors as JSON" do
        post :create, tweet: { content: "" }

        errors = JSON.parse(response.body)["errors"]

        expect(response.content_type).to eq 'application/json'
        expect(response.status).to eq 422
        expect(errors).to include "Content can't be blank"
      end
    end

    context "when contents is present" do
      it "returns the newly created object" do
        post :create, tweet: { content: "First Tweets" }, format: :json
        response_body = JSON.parse(response.body)

        expect(response.content_type).to eq 'application/json'
        expect(response.status).to eq 200
        expect(response_body["tweet"]["content"]).to eq "First Tweets"
        expect(response).to match_response_schema "tweet"
      end
    end
  end

  describe "POST #update" do
    before :each do
      @tweet = create :tweet
    end

    context "when content is an empty string" do
      it "validates the presence of new content" do
        post :update, id: @tweet.id, tweet: { content: "" }

        errors = JSON.parse(response.body)["errors"]

        expect(response.status).to eq 422
        expect(errors).to include "Content can't be blank"
        expect(errors).to include "Content is too short (minimum is 1 characters)"
      end
    end

    context "when content is provided" do
      it "updates the tweet with the new content and returns JSON" do
        post :update, id: @tweet.id, tweet: { content: "Updated" }, format: :json

        expect(JSON.parse(response.body)["tweet"]["content"]).to eq "Updated"
        expect(response.status).to eq 200
        expect(response).to match_response_schema "tweet"
      end

      it "validates the tweet is not too long" do
        content = 160.times.inject("") { |str, i| str + "a" }
        post :update, id: @tweet.id, tweet: { content: content }, format: :json

        errors = JSON.parse(response.body)["errors"]

        expect(errors).to include "Content is too long (maximum is 140 characters)"
      end
    end
  end

  describe "#show" do
    before(:each) do 
      @user = create :user
      @tweet = create :tweet 
    end

    it "fetches the tweet as json" do
      get :show, id: @tweet.id, format: :json

      expect(response).to match_response_schema "tweet"
    end

    it "returns a 404 if the tweet is not found" do
      get :show, id: @tweet.id + 1, format: :json

      expect(response.status).to be 422
      expect(response).to match_response_schema "not_found"
    end
  end
end
