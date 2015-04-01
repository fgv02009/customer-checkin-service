class Visit < ActiveRecord::Base
  belongs_to :business
  belongs_to :user

  def check_daily_code
    self.daily_code == self.business.daily_code
  end
end
