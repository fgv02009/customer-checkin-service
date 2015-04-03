require 'spec_helper'

describe Business do
  let(:business1) {
  Business.create(name: "Taco Bell", address: "100 W Randolph St. Chicago, IL", daily_code: "abcd", password_hash: BCrypt::Password.create("password"))
  }
  let(:business2) {
  Business.create(name: "Mcdonalds", address: "100 N Baker St. Chicago, IL", daily_code: "efgh", password_hash: BCrypt::Password.create("password"))
  }
  let(:business3) {
  Business.create(name: "Dairy Queen", address: "100 S 8th St. Chicago, IL", daily_code: "ijkl", password_hash: BCrypt::Password.create("password"))
  }

  let(:user) {
    User.create(username: "fgv", email: "fgv@gmail.com", password: "password")
  }

  # describe 'update_daily_codes' do
  #   before do
  #     @business4 = Business.create(name: "Wendys", address: "130 W Randolph St. Chicago, IL", daily_code: "abcd", password_hash: BCrypt::Password.create("password"))
  #   end
  #   it 'updates the daily code of each business' do
  #   Business.update_daily_codes
  #   expect(@business4.daily_code).not_to eq("abcd")
  #   # expect{Business.update_daily_codes}.to change{business1.daily_code}
  #   end
  # end

  describe 'checkins' do
    before do
      Visit.create(user: user, business: business1, daily_code: "abcd")
    end
    it 'returns a hash with a key of checkins and a value equal to the count of checkins that business has had' do
      expect(business1.checkins).to eq({checkins: 1})
      expect(business2.checkins).to eq({checkins: 0})
    end
  end
end
