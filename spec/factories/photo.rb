FactoryGirl.define do
  factory :photo do
    association :candidate
    content { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'files', 'lonelybot.png')) }
  end

  factory :invalid_file_type_photo, class: Photo do
    association :candidate
    content { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'files', 'invalid_photo.txt')) }
  end
end

