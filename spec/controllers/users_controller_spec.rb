require 'rails_helper'

RSpec.describe UsersController do
  describe "GET #new" do
    it "redirects the user to the new view" do
      get :new

      expect(response).to render_template(:new)
    end
  end
end
