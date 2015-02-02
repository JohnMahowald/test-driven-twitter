require 'rails_helper'

RSpec.describe Api::TweetsController do
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
      end
    end

    context "when content is provided" do
      it "updates the tweet with the new content and returns JSON" do
        post :update, id: @tweet.id, tweet: { content: "Updated" }, format: :json

        expect(JSON.parse(response.body)["tweet"]["content"]).to eq "Updated"
        expect(response.status).to eq 200
        expect(response).to match_response_schema "tweet"
      end
    end
  end
end
