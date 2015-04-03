require 'spec_helper'

def app
  ApplicationApi
end

describe VisitsApi do
  include Rack::Test::Methods

  describe 'POST /visits' do
    before do
      User.create(username: "flori", email: "flori@flori.com", password: "password")
      Business.create(name: "Chicago Steak", address: "212 N State St. Chicago, IL", daily_code: "abcd", password: "password")
    end

    let(:params) {
      {email: "flori@flori.com",
      password: "password",
      business_name: "Chicago Steak",
      daily_code: "abcd"}
      }

    it 'creates a visit' do
      user = User.find_by(email: params[:email])
      expect{post "visits", params}.to change{Visit.all.count}.from(0).to(1)
    end

    it 'creates a visit with the correct user and business data' do
      post "/visits", params
      expect(parsed_response.data.business.name).to eq("Chicago Steak")
      expect(parsed_response.data.user.username).to eq("flori")
      expect(parsed_response.data.business.address).to eq("212 N State St. Chicago, IL")
    end

    it 'creates a visit for the user' do
      user = User.find_by(email: "flori@flori.com")
      expect{post "/visits", params}.to change{user.visits.count}.from(0).to(1)
    end

    it 'creates a visit for the business' do
    business = Business.find_by(name: "Chicago Steak")
      expect{post "/visits", params}.to change{business.visits.count}.from(0).to(1)
    end

    it 'gives a user 5 points for that business' do
      user = User.find_by(email: "flori@flori.com")
        expect{post "/visits", params}.to change{user.points}.from({}).to({"Chicago Steak" => 5})
    end

    it 'gives a business a checkin' do
      business = Business.find_by(name: "Chicago Steak")
      expect{post "/visits", params}.to change{business.checkins[:checkins]}.from(0).to(1)
    end
  end
end
