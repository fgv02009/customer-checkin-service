require 'spec_helper'

describe User do
  let(:business) {
  Business.create(name: "Taco Bell", address: "100 W Randolph St. Chicago, IL", daily_code: "abcd", password_hash: BCrypt::Password.create("password"))
  }

  let(:business2) {
  Business.create(name: "Mcdonalds", address: "100 N Baker St. Chicago, IL", daily_code: "efgh", password_hash: BCrypt::Password.create("password"))
  }

  let(:user1) {
    User.create(username: "fgv", email: "fgv@gmail.com", password: "password")
  }

  let(:user2) {
    User.create(username: "sarah", email: "sarah@gmail.com", password: "password")
  }
  describe 'checkins'
    before do
      Visit.create(user: user1, business: business, daily_code: "abcd")
    end
    it 'should return the number of checkins that user has' do
      expect(user1.checkins).to eq(1)
      expect(user2.checkins).to eq(0)
    end

  describe 'points_at_bus' do
    before do
      Visit.create(user: user1, business: business, daily_code: "abcd")
    end
    it 'returns the points for a user at a specific business (5* the number of visits)' do
      expect(user1.points_at_bus(business)).to eq(5)
      expect(user1.points_at_bus(business2)).to eq(0)
    end
  end

  describe 'points' do
    before do
      Visit.create(user: user1, business: business, daily_code: "abcd")
      Visit.create(user: user1, business: business2, daily_code: "efgh")
    end
    it 'returns a hash with businesses as the keys and number of points as the values for a specific user' do
      expect(user1.points).to eq({"Taco Bell"=>5, "Mcdonalds"=>5})
    end
  end
end
