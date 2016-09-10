require 'rails_helper'
include ControllerHelper
include ResponseHelper

RSpec.describe PhotosController, :type => :controller do
  describe "POST #create" do
    it "responds succesfully with created photo" do
      user = create(:user)
      create(:candidate, user: user)
      login(user)
      file = fixture_file_upload('files/lonelybot.png', 'image/png')

      post :create, params: { photo: {content: file} }
      expect(response).to be_success
    end
  end
end

