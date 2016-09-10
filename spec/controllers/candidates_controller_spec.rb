require 'rails_helper'
include ControllerHelper
include ResponseHelper

RSpec.describe CandidatesController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      login(create(:user))
      get :index, params: { candidate_id: create(:candidate).id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    describe "order=match" do
      it "should return candidates ordered by match" do
        candidate = create(:candidate, rating: 1500)

        candidates = [create(:candidate, rating: 1450),
                      create(:candidate, rating: 1300),
                      create(:candidate, rating: 1525),
                      create(:candidate, rating: 1500)]

        # The provdied candidate should be excluded, you can't match to yourself
        # Candidates with a rating difference greater than 100 are also excluded
        expected_order = [candidates[3], candidates[2], candidates[0]]

        login(candidate.user)
        get :index, params: { candidate_id: candidate.id, order: 'match' }

        expect(assigns(:candidates)).to match_array(expected_order)
      end
    end

    describe "filters" do
      describe "f" do
        it "should return only the female candidates" do
          males = create_list(:candidate, 3, gender: Candidate::MALE)
          females = create_list(:candidate, 2, gender: Candidate::FEMALE)

          login(males[0].user)
          get :index, params: { candidate_id: males[0].id, filters: [CandidateOptions::FEMALE_FILTER] }

          expect(assigns(:candidates)).to match_array(females)
        end
      end

      describe "has_bio" do
        it "should return candidates with a bio" do
          candidates_without_bio = create_list(:candidate, 3, biography: nil)
          candidates_with_bio = create_list(:candidate, 2, biography: "Has Bio")

          login(candidates_without_bio[0].user)
          get :index, params: { candidate_id: candidates_without_bio[0].id, filters: [CandidateOptions::HAS_BIO_FILTER] }

          expect(assigns(:candidates)).to match_array(candidates_with_bio)
        end
      end

      describe "has_photo" do
        it "should return candidates with photos" do
          candidates_with_photo = create_list(:candidate, 3)
          candidates_with_photo.each {|candidate| create(:photo, candidate: candidate)}
          candidates_without_photo = create_list(:candidate, 2)

          login(candidates_without_photo[0].user)
          get :index, params: { candidate_id: candidates_without_photo[0].id, filters: [CandidateOptions::HAS_PHOTO_FILTER] }

          expect(assigns(:candidates)).to match_array(candidates_with_photo)
        end
      end
    end
  end

  describe "POST #create" do
    it "creates a new candidate associated with the current user" do
      user = login
      biography = "I'm just a lonely test bot."
      expect{post :create, params: { candidate: {gender: Candidate::FEMALE, biography: biography } }}.to change(Candidate, :count).by(1)

      expect(response).to be_success
      expect(response_body[:user_id]).to eq(user.id)
      expect(response_body[:gender]).to eq(Candidate::FEMALE)
      expect(response_body[:biography]).to eq(biography)
      expect(response_body[:rating]).to eq(nil)
      expect(response_body[:games_played]).to eq(nil)
    end

    it "should not allow invalid gender" do
      login
      expect{post :create, params: { candidate: {gender: 'x'} }}.to change(Candidate, :count).by(0)

      expect(response.status).to eq(422)
      expect(response_body.key?(:gender)).to eq(true)
      expect(response_body[:gender]).to eq(["is not included in the list"])
    end
  end

  describe "PUT #update" do
    it "responds successfully with an HTTP 200 status code" do
      login
      put :update, params: { id: create(:candidate).id, target_id: create(:candidate).id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    describe "likes" do
      it "should decrease the candidate's rating and increase the targets rating" do
        candidate, target = create(:candidate), create(:candidate)
        before_candidate_rating = candidate.rating
        before_target_rating = target.rating

        login(candidate.user)
        put :update, params: { id: candidate.id, target_id: target.id, likes: true }

        expect(candidate.reload.rating).to be < before_candidate_rating
        expect(target.reload.rating).to be > before_target_rating
      end
    end

    describe "dislikes" do
      it "should increase the candidate's rating and decrease the targets rating" do
        candidate, target = create(:candidate), create(:candidate)
        before_candidate_rating = candidate.rating
        before_target_rating = target.rating

        login(candidate.user)
        put :update, params: { id: candidate.id, target_id: target.id, likes: false }

        expect(candidate.reload.rating).to be > before_candidate_rating
        expect(target.reload.rating).to be < before_target_rating
      end
    end
  end
end


