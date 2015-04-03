class Business < ActiveRecord::Base
  has_many :visits
  has_many :guests, through: :visits, source: :user

  validates_presence_of :name, :address
  validates_uniqueness_of :address

  def self.authenticate(id, password)
    business = Business.find(id)
    if business && business.password == password
      return business
    end
  end

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def self.update_daily_codes
    daily_coding_arr = ("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a
    self.all.each do |business|
      business.update_attribute(:daily_code, daily_coding_arr.sample(4).join(""))
      business.save
    end
  end

  def checkins
    return {checkins: self.visits.count}
  end
end
