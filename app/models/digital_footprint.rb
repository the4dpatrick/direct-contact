class DigitalFootprint < ActiveRecord::Base
  belongs_to :contact
  has_many :scores
  has_many :topics
end
