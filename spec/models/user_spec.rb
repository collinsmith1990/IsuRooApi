require 'rails_helper'

RSpec.describe User, :type => :model do
  it "should be valid" do
    expect(build(:user)).to be_valid
  end

  describe "username" do
    it "should be present" do
      expect(build(:user, username: nil)).to be_invalid
    end

    it "should be unique" do
      create(:user, username: "AxelRose")

      expect(build(:user, username:"AxelRose")).to be_invalid
    end
  end

  describe "email" do
    it "should be present" do
      expect(build(:user, email: "")).to be_invalid
    end

    it "should be a valid email" do
      expect(build(:user, email: "invalidemail")).to be_invalid
    end

    it "should be unique" do
      create(:user, email: "AxelRose@example.com")

      expect(build(:user, email:"AxelRose@example.com")).to be_invalid
    end

    it "should be case insensitive" do
      user = create(:user, email: "AxelRose@example.com")
      expect(User.find_by(email: "axelrose@example.com")).to eq(user)
    end
  end

  describe "password" do
    it "should be present" do
      expect(build(:user, password: "")).to be_invalid
    end
  end

  describe "authenticate" do
    it "should return user if correct password is passed" do
      user = create(:user, password: "testpass")
      expect(user.authenticate("testpass")).to eq(user)
    end

    it "should return false if incorrect password is passed" do
      user = create(:user, password: "testpass")
      expect(user.authenticate("wrongpass")).to eq(false)
    end
  end

  describe "destroy" do
    context "candidate" do
      it "should be destroyed when the user is destroyed" do
        user = create(:user)
        candidate = create(:candidate, user: user)

        user.destroy

        expect(Candidate.find_by(id: candidate.id)).to eq(nil)
      end
    end
  end
end

