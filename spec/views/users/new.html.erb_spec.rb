require 'rails_helper'

RSpec.describe "Users#new" do
  describe "Creating a new user" do
    it "exists" do
      visit "/users/new"

      expect(page).to have_content("Hello, World!")
    end

    it "has a input for entering username" do
      visit "/users/new"

      expect(page).to have_selector("input[name='user[password]']")
    end

    it "has an input for entering password" do
      visit "/users/new"

      expect(page).to have_selector("input[name='user[username]']")
    end

    describe "Error handling" do
      it "renders an error when the password is too short" do
        visit "/users/new"

        fill_in("user[password]", with: "short")
        click_button("Sign up for Twitter")

        expect(page).to have_content(/Password is too short \(minimum is 6 characters\)/)
      end

      # it "renders an error when the username is not entered" do
      # end
      #
      # it "renders an error when the username is already taken" do
      # end
      #
      # it "renders an error when the email is not entered" do
      # end
      #
      # it "renders an error when the email is already taken" do
      # end
    end
  end
end
