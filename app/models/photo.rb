class Photo < ActiveRecord::Base
  belongs_to :candidate, validate: true
  mount_uploader :content, PhotoUploader
  validate :photo_size

  private

  def photo_size
    if content.size > 10.megabytes
      errors.add(:photo, "should be less than 10MB")
    end
  end
end
