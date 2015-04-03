require 'spec_helper'

def app
  ApplicationApi
end

describe UsersApi do
  include Rack::Test::Methods

  describe 'GET /users' do
    before do
      params = {
        username: "Sally",
        email: "sally@test.com",
        password: "test"
      }
      post :users, params
    end
    it 'returns to you all the users' do
      get "/users"
      # expect(JSON.parse(response_body.data)).to be_kind_of(Array)
      expect(parsed_response.data).to be_kind_of(Array)
      expect(parsed_response.data[0].username).to eq("Sally")
      expect(parsed_response.data[0].email).to eq("sally@test.com")
      expect(parsed_response.data[0].password).not_to eq("test")
    end
  end

  describe 'GET /users/:id' do
    before do
      params = {
        username: "Matt",
        email: "matt@gmail.com",
        password: "password"
      }
      post :users, params
    end
    it 'returns to you the user with that id' do
      get "/users/2"
      p users = User.all
      email = User.find(2).email
      username = User.find(2).username
      password = User.find(2).password
      # expect(JSON.parse(response_body.data)).to be_kind_of(Array)
      expect(parsed_response.data.username).to eq(username)
      expect(parsed_response.data.email).to eq(email)
      expect(parsed_response.data.password).not_to eq("password")
    end
  end
  describe 'POST /users' do
    it 'returns to you the new business you just created' do
      params = {
        username: "Betty",
        email: "betty@gmail.com",
        password: "password"
      }
      post :users, params
      expect(parsed_response.data.username).to eq("Betty")
      expect(parsed_response.data.email).to eq("betty@gmail.com")
      expect(parsed_response.data.password).not_to eq("password")
    end
  end
end