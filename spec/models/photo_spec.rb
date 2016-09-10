require 'rails_helper'
include CarrierWave::Test::Matchers

RSpec.describe Photo, :type => :model do
  it "should be valid" do
    expect(build(:photo)).to be_valid
  end

  it "should only allow image files" do
    expect(build(:invalid_file_type_photo)).to be_invalid
  end

  it "should resize images to fill 600px x 750px " do
    photo = create(:photo)

    expect(photo.content).to have_dimensions(600, 750)
  end

  it "should only allow five photos per candidate" do
    candidate = create(:candidate)
    create_list(:photo, 5, candidate: candidate)
    candidate.reload

    expect(build(:photo, candidate: candidate)).to be_invalid
  end
end
