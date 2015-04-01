class Business < ActiveRecord::Base
  has_many :visits
  has_many :guests, through: :visits, source: :user

  before_create {self.update_daily_code}
  def update_daily_code
    daily_coding_arr = ("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a
    # every 1.day, :at => '12:00 pm' do
    #   self.daily_code = daily_coding_arr.sample(4).join("")
    # end
    every 10.seconds do
      self.daily_code = daily_coding_arr.sample(4).join("")
    end
  end
end
