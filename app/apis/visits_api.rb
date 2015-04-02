class VisitsApi < Grape::API
  resource :visits do

    desc 'Get a list of visits'
    params do
      optional :ids, type: Array, desc: 'Array of visit ids'
    end
    get do
      visits = params[:ids] ? Visit.where(id: params[:ids]) : Visit.all
      represent visits, with: VisitRepresenter
    end

    desc 'Create an visit'
    params do
      requires :email, type: String, desc: 'The email of the user'
      requires :password, type: String, desc: 'The password of the user'
      requires :business_name, type: String, desc: 'The name of the business'
      requires :daily_code, type: String, desc: 'Users input of daily string'
    end

    post do
      user = User.authenticate(params[:email], params[:password])
      business = Business.find_by(name: params[:business_name])
      daily_code = params[:daily_code]
      if user
        visit = Visit.new(user: user, business: business, daily_code: daily_code)
        if visit.check_daily_code && !visit.already_checked_in_today?(business, user, daily_code)
          visit.save
          represent visit, with: VisitRepresenter
        else
          {message: "You either have the wrong code to check into #{params[:business_name]} or you have already checked in once today."}
        end
      else
        {message: "That is the incorrect email or password"}
      end
    end

    route_param :id do
      desc 'Get a visit'
      params do
        requires :id, desc: 'ID of the visit'
      end
      get do
        visit = Visit.find(params[:id])
        represent visit, with: VisitRepresenter
      end

      desc 'Update an visit'
      params do
      end
      put do
        # fetch visit record and update attributes.  exceptions caught in app.rb
        visit = Visit.find(params[:id])
        visit.update_attributes!(permitted_params)
        represent visit, with: VisitRepresenter
      end
    end
  end
end
