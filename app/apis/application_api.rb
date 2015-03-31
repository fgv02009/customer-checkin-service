class ApplicationApi < Grape::API
  format :json
  extend Napa::GrapeExtenders

  # mount HelloApi => '/'
  mount UsersApi => '/'

  add_swagger_documentation
end

