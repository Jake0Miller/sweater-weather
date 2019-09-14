class Api::V1::CoordinatesController < ApplicationController
  def show
    binding.pry
    coords = Geocoder.new(city, state).coords
    render json: CoordSerializer.new(coords)
  end
end
