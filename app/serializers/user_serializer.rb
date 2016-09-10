class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :auth_token
end
