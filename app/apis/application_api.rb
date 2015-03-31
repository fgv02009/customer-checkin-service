class ApplicationApi < Grape::API
  format :json
  extend Napa::GrapeExtenders

  # mount HelloApi => '/'
  mount UsersApi => '/'
  mount BusinessesApi => '/'

  add_swagger_documentation
end

