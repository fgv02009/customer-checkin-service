class Visit < ActiveRecord::Base
  belongs_to :business
  belongs_to :user

  validates_presence_of :business, :user, :daily_code
  validate :already_checked_in_today?
  validate :check_daily_code

  def check_daily_code
    if self.daily_code != self.business.daily_code
      errors.add(:daily_code, "is incorrect")
    end
  end

  def already_checked_in_today?
    if !Visit.where(business: business, user: user, daily_code: daily_code).empty?
      errors.add(:user, "has already checked in today")
    end
  end
end
