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
        expect(response).to match_response_schema("tweet")
      end
    end
  end
end
