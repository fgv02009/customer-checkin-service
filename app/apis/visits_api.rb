class VisitsApi < Grape::API
  resource :visits do


    #How a user checks in
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
        if visit.save
          represent visit, with: VisitRepresenter
        else
          {message: "You either have the wrong code to check into #{params[:business_name]} or you have already checked in once today."}
        end
      else
        {message: "That is the incorrect email or password"}
      end
    end
  end
end
