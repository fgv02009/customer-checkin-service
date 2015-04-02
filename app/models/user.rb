class User < ActiveRecord::Base
  has_many :visits
  has_many :checkins, through: :visits, source: :business


  def self.authenticate(email, password)
    user = User.find_by(email: email)
    if user && user.password == password
      return user
    end
  end

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def checkins
    self.visits.count
  end

  def points_at_bus(business)
    (self.visits.where(business: business).count)*5
  end

  def points
    business_points = {}
    Business.all.each do |business|
      business_points[business.name] = points_at_bus(business)
    end
    business_points.each do |bus_name, pts|
      if pts == 0
        business_points.delete(bus_name)
      end
    end
    business_points
  end
end
