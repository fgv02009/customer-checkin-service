class Business < ActiveRecord::Base
  has_many :visits
  has_many :guests, through: :visits, source: :user

  validates_presence_of :name, :address
  validates_uniqueness_of :address


  def self.update_daily_codes
    daily_coding_arr = ("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a
    self.all.each do |business|
      business.daily_code = daily_coding_arr.sample(4).join("")
    end
  end

  def day
    self.created_at.yday-1
  end

  def checkins
    return {checkins: self.visits.count}
  end
end
