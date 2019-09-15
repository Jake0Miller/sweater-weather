class Location < ApplicationRecord
  validates_presence_of :name, :address, :lat, :lng
  has_one :image
  has_many :forecasts
end
