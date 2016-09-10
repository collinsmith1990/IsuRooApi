require 'rails_helper'
include ControllerHelper
include ResponseHelper

RSpec.describe UsersController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      login

      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads all users into @users" do
      users = create_list(:user, 3)
      login(users[0])

      get :index

      expect(assigns(:users)).to match_array(users)
    end
  end

  describe "POST #create" do
    it "creates a new user" do
      user_params = {user: 
                     {username: "LonliestBot",
                      email: "LonliestBot@example.com",
                      password: "testpass",
                      password_confirmation: "testpass"}
                    }

      expect{post :create, params: user_params}.to change(User, :count).by(1)
      expect(response).to be_success
      expect(response_body[:username]).to eq("LonliestBot")
      expect(response_body[:email]).to eq("lonliestbot@example.com")
      expect(response_body[:auth_token]).to_not eq(nil)
      expect(response_body[:password_digest]).to eq(nil)
    end

    it "should respond with a 400 error if password and password_confirmation don't match" do
      user_params = {user: 
                     {username: "LonliestBot",
                      email: "LonliestBot@example.com",
                      password: "testpass",
                      password_confirmation: ""}
                    }

      expect{post :create, params: user_params}.to change(User, :count).by(0)
      expect(response.status).to eq(422)
      expect(response_body.key?(:password_confirmation)).to eq(true)
      expect(response_body[:password_confirmation]).to eq(["doesn't match Password"])
    end
  end
end

