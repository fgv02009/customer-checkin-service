class UsersApi < Grape::API
  # format :json
  helpers do
    # def current_user
    #   @current_user ||= User.authorize!(env)
    # end

    # def authenticate!
    #   error!('401 Unauthorized', 401) unless current_user
    # end
    #  def permitted_params
    #   @permitted_params ||= declared(params, include_missing: false)
    # end
  end

  resource :users do
    desc 'Get a list of users'
    params do
      optional :ids, type: Array, desc: 'Array of user ids'
    end
    get do
      users = params[:ids] ? User.where(id: params[:ids]) : User.all
      represent users, with: UserRepresenter
    end

    # desc 'Show new form for signup'
    # get :new do
    #   user = User.new
    #   represent user, with:UserRepresenter
    # end

    desc 'Create an user'
    params do
      requires :username, type: String, desc: 'The Username of the user'
      requires :email, type: String, desc: 'The email of the user'
      requires :password, type: String, desc: 'The password of the person'
    end
    post do
      user = User.create!(username: params[:username], email: params[:email], password:params[:password])
      error!(present_error(:record_invalid, user.errors.full_messages)) unless user.errors.empty?
      represent user, with: UserRepresenter
    end

    route_param :id do
      desc 'Get an user'
      params do
        requires :id, desc: 'ID of the user'
      end
      get do
        user = User.find(params[:id])
        represent user, with: UserRepresenter
      end

      desc 'Update an user'
      params do
        optional :username, type: String, desc: 'The Username of the user'
        optional :email, type: String, desc: 'The email of the user'
        optional :password, type: String, desc: 'The password of the person'
      end

      put do
        user = User.find(params[:id])
        user.update_attributes!(permitted_params)
        represent user, with: UserRepresenter
      end

      desc 'Get a users check in point'
      get :points do
        user = User.find(params[:id])
        user.points
      end

    end

  end
end
