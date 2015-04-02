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
        daily_code: "1234"
      }
      post :businesses, params
    end
    it 'returns to you all the businesses' do
      get "/businesses"
      # expect(JSON.parse(response_body.data)).to be_kind_of(Array)
      expect(parsed_response.data).to be_kind_of(Array)
      expect(parsed_response.data[0].name).to eq("Reza")
      expect(parsed_response.data[0].address).to eq("300 W Ontario St. Chicago, IL")
      expect(parsed_response.data[0].daily_code).to eq("1234")
    end
  end

  describe 'GET /businesses/:id' do
    before do
      params = {
        name: "Avec",
        address: "1200 W Randolph St. Chicago, IL",
        daily_code: "ABCD"
      }
      post :businesses, params
    end
    it 'returns to youthe business with that id' do
      get "/businesses/2"
      p businesses = Business.all
      name = Business.find(2).name
      daily_code = Business.find(2).daily_code
      address = Business.find(2).address
      # expect(JSON.parse(response_body.data)).to be_kind_of(Array)
      expect(parsed_response.data.name).to eq(name)
      expect(parsed_response.data.address).to eq(address)
      expect(parsed_response.data.daily_code).to eq(daily_code)
    end
  end
  describe 'POST /businesses' do
    it 'returns to you the new business you just created' do
      params = {
        name: "Reza",
        address: "300 W Ontario St. Chicago, IL",
        daily_code: "1234"
      }
      post :businesses, params
      expect(parsed_response.data.name).to eq("Reza")
      expect(parsed_response.data.address).to eq("300 W Ontario St. Chicago, IL")
      expect(parsed_response.data.daily_code).to eq("1234")
    end
  end
end