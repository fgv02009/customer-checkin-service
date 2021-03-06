class BusinessesApi < Grape::API
  resource :businesses do

    desc 'Get a list of businesses'
    params do
      optional :ids, type: Array, desc: 'Array of business ids'
    end
    get do
      businesses = params[:ids] ? Business.where(id: params[:ids]) : Business.all
      represent businesses, with: BusinessRepresenter
    end

    desc 'Create an business'
    params do
      requires :name, type: String, desc: 'The Name of the business'
      requires :address, type: String, desc: 'The address of the business'
      requires :daily_code, type: String, desc: 'The daily_code of the business'
      requires :password , type: String, desc: 'The password for the business'
    end

    post do
      business = Business.create!(name: params[:name], address: params[:address], daily_code: params[:daily_code], password: params[:password])
      represent business, with: BusinessRepresenter
    end

    route_param :id do
      desc ' Get a specific business'
      params do
       requires :id, desc: 'ID of the business'
      end

      get do
        business = Business.find(params[:id])
        represent business,
        with: BusinessRepresenter
      end

      desc 'Get the checkin count of a business'
      params do
        requires :password, desc: 'password of the business'
      end
      get :checkins do
        business = Business.authenticate(params[:id], params[:password])
        if business
          business.checkins
        else
          {message: "You do not have the correct password to see #{business}' checkins"}
        end
      end

      desc 'get the daily_code'
      get :daily_code do
        params do
          requires :password, desc: 'password of the business'
        end
        business = Business.authenticate(params[:id], params[:password])
        if business
          business.daily_code
        else
          {message: "You do not have the correct password to see #{business}' daily_code"}
        end
      end
    end
  end
end
