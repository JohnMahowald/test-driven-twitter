require 'rails_helper'

RSpec.describe "Signing In" do
  it "can sign a user in" do
    @user = create :user

    visit("/")
    fill_in("session[username]", with: @user.username)
    fill_in("session[password]", with: @user.password)
    click_button("Log in")

    expect(page).to have_content "Hello World"
  end
end
