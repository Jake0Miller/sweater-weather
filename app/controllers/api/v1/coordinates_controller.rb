class Api::V1::CoordinatesController < ApplicationController
  def show
    location = LocationFacade.new(params[:location].downcase).location
    render json: CoordSerializer.new(location)
  end
end
