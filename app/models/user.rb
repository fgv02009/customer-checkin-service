class User < ActiveRecord::Base
  has_many :visits
  has_many :checkins, through: :visits, source: :business
end
