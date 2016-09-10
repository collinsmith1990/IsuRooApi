require 'rails_helper'

RSpec.describe AuthenticationController, :type => :controller do
  describe "POST #authenticate" do
    it "responds successfully with an HTTP 200 status code and returns an auth_token" do
      user = create(:user, email: "LonelyBot@example.com", password: "testpass")

      post :authenticate, params: { email: "LonelyBot@example.com", password: "testpass" }

      expect(response).to be_success
      expect(response).to have_http_status(200)

      auth_token = eval(response.body)[:auth_token]
      expect(auth_token).to_not eq(nil)

      decoded_token = JsonWebToken.decode(auth_token)

      expect(decoded_token[:user_id]).to eq(user.id)
    end
  end
end


