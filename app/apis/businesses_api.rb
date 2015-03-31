class BusinessesApi < Grape::API
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
  optional :name, type: String, desc: 'The Name of the business'
  optional :address, type: String, desc: 'The address of the business'
  optional :daily_code, type: String, desc: 'The daily_code of the business'
  end

  post do
    business = Business.create!(permitted_params)
    represent business, with: BusinessRepresenter
  end

  params do
    requires :id, desc: 'ID of the business'
  end
  route_param :id do
    desc 'Get an business'
    get do
      business = Business.find(params[:id])
      represent business, with: BusinessRepresenter
    end

    desc 'Update an business'
    params do
      optional :name, type: String, desc: 'The name of the business'
      optional :address, type: String, desc: 'The address of the business'
      optional :daily_code, type: String, desc: 'The daily code of the business'
    end
    put do
      # fetch business record and update attributes.  exceptions caught in app.rb
      business = Business.find(params[:id])
      business.update_attributes!(permitted_params)
      represent business, with: BusinessRepresenter
    end
  end
end
