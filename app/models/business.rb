class Business < ActiveRecord::Base
  has_many :visits
  has_many :guests, through: :visits, source: :user
end
