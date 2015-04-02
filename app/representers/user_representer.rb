class UserRepresenter < Napa::Representer
  property :id, type: String
  property :username
  property :email
  property :password
end
