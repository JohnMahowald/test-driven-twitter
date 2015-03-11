require 'rails_helper'

RSpec.describe "Signing In" do
  it "can sign a user in" do
    @user = create :user

    expect(page.has_button? "Sign out").to be false

    visit("/")
    fill_in("session[username]", with: @user.username)
    fill_in("session[password]", with: @user.password)
    click_button("Log in")

    expect(page.has_button? "Sign out").to be true
    expect(page).to have_content @user.username
  end
end
