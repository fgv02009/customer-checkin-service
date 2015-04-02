class UserRepresenter < Napa::Representer
  property :id, type: Integer
  property :username
  property :email
  property :password
end
