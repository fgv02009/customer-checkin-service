class UserRepresenter < Napa::Representer
  property :id, type: String
  property :username
  property :email
  property :points
  property :password

end
