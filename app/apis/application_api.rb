class ApplicationApi < Grape::API
  format :json
  extend Napa::GrapeExtenders

  # mount HelloApi => '/'
  mount UsersApi => '/'
  mount BusinessesApi => '/'
  mount VisitsApi => '/'

  add_swagger_documentation
end

