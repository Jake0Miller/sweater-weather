class Gif < ApplicationRecord
  validates_presence_of :description, :url
end
