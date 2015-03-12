require 'rails_helper'

RSpec.describe "the user show page" do
  it "can create a new tweet" do
    @user = create :user

    visit(user_url(@user))
    fill_in("What's happening?", with: "testing")
    click("Tweet")

    expect(page).to have_content "testing"
  end
end
