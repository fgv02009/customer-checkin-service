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
      requires :username, type: String, desc: 'The username of the user'
      requires :business_name, type: String, desc: 'The name of the business'
      requires :daily_code, type: String, desc: 'Users input of daily string'
    end

    post do
      visit = Visit.new(user: User.find_by(username: params[:username]), business: Business.find_by(name: params[:business_name]), daily_code: params[:daily_code])
      if visit.check_daily_code
        visit.save
        represent visit, with: VisitRepresenter
      else
        {message: "That is not the right code to check into #{params[:business_name]}"}
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
