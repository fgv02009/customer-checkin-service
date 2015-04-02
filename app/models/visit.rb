class Visit < ActiveRecord::Base
  belongs_to :business
  belongs_to :user

  def check_daily_code
    self.daily_code == self.business.daily_code
  end

  def already_checked_in_today?(business, user, daily_code)
    !Visit.where(business: business, user: user, daily_code: daily_code).empty?
  end
end
