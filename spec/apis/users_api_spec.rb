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
      user_id = User.find_by(email: "matt@gmail.com").id
      get "/users/#{user_id}"
      email = User.find(user_id).email
      username = User.find(user_id).username
      password = User.find(user_id).password
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

  describe 'Get /users/:id/points' do
    before do
      params = {
        username: "Matt",
        email: "matt@gmail.com",
        password: "password"
      }
      post :users, params
    end
    it 'returns to you the businesses each user has points at and the number of points at that business' do
      params = {
        email: "matt@gmail.com",
        password: "password"
      }
      user_id = User.find_by(email: "matt@gmail.com").id
      get "users/#{user_id}/points", params
      expect(parsed_response).to be_empty
    end
  end
end