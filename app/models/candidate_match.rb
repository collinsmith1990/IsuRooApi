class CandidateMatch < ActiveRecord::Base
   PENDING = 'p'
   YES = 'y'
   NO = 'n'
   EXPIRED = 'e'

   belongs_to :candidate
   belongs_to :match, class_name: "Candidate"

   validates_uniqueness_of :candidate_id, scope: :match_id
   validates_inclusion_of :reply, in: [PENDING, YES, NO, EXPIRED]
   validate :match_isnt_candidate

   scope :pending, -> { where(reply: PENDING) }
   scope :yes, -> { where(reply: YES) }
   scope :no, -> { where(reply: NO) }
   scope :expired, -> { where(reply: EXPIRED) }

   private

   def match_isnt_candidate
     errors.add(:match, "can't be same as candidate") if match == candidate
   end
end
