class Image < ApplicationRecord
  validates_presence_of :raw, :full, :regular, :small, :thumb
  belongs_to :location
end
