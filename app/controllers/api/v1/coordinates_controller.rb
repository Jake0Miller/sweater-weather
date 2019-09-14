class Api::V1::CoordinatesController < ApplicationController
  def show
    coords = Geocoder.new(params[:location]).coords[:results][0][:geometry][:location]
    render json: coords
  end
end
