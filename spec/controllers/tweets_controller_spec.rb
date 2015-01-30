require 'rails_helper'

RSpec.describe Api::TweetsController do
  describe "POST #create" do
    context "when content is not present" do
      it "renders errors as JSON" do
        post :create, tweet: { content: "" }

        errors = JSON.parse(response.body)["errors"]

        expect(response.content_type).to eq 'application/json'
        expect(response.status).to eq 422
        expect(errors).to include("Content can't be blank")
      end
    end

    context "when contents is present" do
      it "returns the newly created object" do
        post :create, tweet: { content: "First Tweets" }

        response_body = JSON.parse(response.body)

        expect(response.content_type).to eq 'application/json'
        expect(response.status).to eq 200
        expect(response_body["content"]).to eq "First Tweets"
        expect(response).to match_response_schema "tweet"
      end
    end
  end

  describe "POST #update" do
    context "when content is empty string" do
      it "validates the presence of new content" do
      end
    end

    context "when content is provided" do
      it "updates the tweet with the new content" do
      end

      it "returns the object as JSON" do
      end
    end
  end
end
