require 'spec_helper'

def app
  ApplicationApi
end

describe BusinessesApi do
  include Rack::Test::Methods

  describe 'GET /businesses' do
    before do
      params = {
        name: "Reza",
        address: "300 W Ontario St. Chicago, IL",
        daily_code: "1234",
        password: "password"
      }
      post :businesses, params
    end
    it 'returns to you all the businesses' do
      get "/businesses"
      expect(parsed_response.data).to be_kind_of(Array)
      expect(parsed_response.data[0].name).to eq("Reza")
      expect(parsed_response.data[0].address).to eq("300 W Ontario St. Chicago, IL")
    end
  end

  describe 'GET /businesses/:id' do
    before do
      params = {
        name: "Avec",
        address: "1200 W Randolph St. Chicago, IL",
        daily_code: "ABCD",
        password: "password"
      }
      post :businesses, params
    end
    it 'returns to youthe business with that id' do
       business_id = Business.find_by(name: "Avec").id
      get "/businesses/#{business_id}"
      name = Business.find(business_id).name
      daily_code = Business.find(business_id).daily_code
      address = Business.find(business_id).address
      expect(parsed_response.data.name).to eq(name)
      expect(parsed_response.data.address).to eq(address)
    end
  end
  describe 'POST /businesses' do
    it 'returns to you the new business you just created' do
      params = {
        name: "Reza",
        address: "300 W Ontario St. Chicago, IL",
        daily_code: "1234",
        password: "password"
      }
      post :businesses, params
      expect(parsed_response.data.name).to eq("Reza")
      expect(parsed_response.data.address).to eq("300 W Ontario St. Chicago, IL")
    end
  end

  describe 'GET/businesses/:id/checkins' do
    before do
      params = {
        name: "Avec",
        address: "1200 W Randolph St. Chicago, IL",
        daily_code: "ABCD",
        password: "password"
      }
      post :businesses, params
    end
    params = {
      password: "password"
    }
    it 'returns to you the number of checkins that business has' do
    business_id = Business.find_by(name: "Avec").id
      get "/businesses/#{business_id}/checkins", params
      expect(parsed_response).to eq({"checkins" => 0})
       get "/businesses/#{business_id}/checkins"
      expect(parsed_response.error.message).to eq("password is missing")
    end
  end

end