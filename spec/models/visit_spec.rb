require 'spec_helper'

describe Visit do
  let(:business) {
  Business.create(name: "Taco Bell", address: "100 W Randolph St. Chicago, IL", daily_code: "abcd", password_hash: BCrypt::Password.create("password"))
  }

  let(:user1) {
    User.create(username: "fgv", email: "fgv@gmail.com", password: "password")
  }


  describe 'check_daily_code' do
    before do
      @visit1 = Visit.new(user: user1, business: business, daily_code: "efgh")
    end
    it "raise an error if the daily code entered into the visit is not equal to the business' daily code" do
      @visit1.valid?
      expect(@visit1.errors.full_messages).to include("Daily code is incorrect")
    end
  end

  describe 'already_checked_in_today?' do
    before do
      @visit1 = Visit.create(user: user1, business: business, daily_code: "abcd")
      @visit2 = Visit.new(user: user1, business: business, daily_code: "abcd")
    end
    it 'raises an error if a user has already checked into a business that day' do
      @visit2.valid?
      expect(@visit2.errors.full_messages).to include("User has already checked in today")
    end
  end
end
