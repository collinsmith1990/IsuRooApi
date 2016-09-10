class CandidateSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :gender, :biography
  has_many :photos
end
