class UsersApi < Grape::API

  resource :users do
    desc 'Get a list of users'
    params do
      optional :ids, type: Array, desc: 'Array of user ids'
    end
    get do
      users = params[:ids] ? User.where(id: params[:ids]) : User.all
      represent users, with: UserRepresenter
    end

    desc 'Create an user'
    params do
      requires :username, type: String, desc: 'The Username of the user'
      requires :email, type: String, desc: 'The email of the user'
      requires :password, type: String, desc: 'The password of the person'
    end
    post do
      # user = User.create(declared(params, include_missing: false))
      # user = User.create!(permitted_params)
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

      desc 'Get a users check in point'
      params do
        requires :email, desc: "email of the user"
        requires :password, desc: "password of the user"
      end
      get :points do
        user = User.authenticate(params[:email], params[:password])
        if user
          user.points
        else
          {message: "incorrect password"}
        end
      end
    end
  end
end
