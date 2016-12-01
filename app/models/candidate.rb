class Candidate < ActiveRecord::Base
  MALE = 'm'
  FEMALE = 'f'

  belongs_to :user
  has_many :matches, class_name: "CandidateMatch"
  has_many :photos

  validates_numericality_of :games_played, only_integer: true
  validates_numericality_of :games_played, greater_than_or_equal_to: 0
  validates_numericality_of :rating, greater_than_or_equal_to: 0
  validates_inclusion_of :gender, in: [MALE, FEMALE]
  validates :biography, length: { maximum: 500 }
  validates :photos, length: { maximum: 4 }

  # Filters
  scope :male, -> { where(gender: MALE) }
  scope :female, -> { where(gender: FEMALE) }
  scope :has_bio, -> { where("candidates.biography IS NOT NULL") }
  scope :has_photo, -> { where("EXISTS (SELECT 1 FROM photos WHERE photos.candidate_id = candidates.id)") }

  # Order
  scope :rating_order, -> { order("rating DESC") }

  def likes(candidate)
    Rater.new(self).likes(candidate)
  end

  def dislikes(candidate)
    Rater.new(self).dislikes(candidate)
  end
end
