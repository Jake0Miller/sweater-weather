class Api::V1::RoadTripController < ApplicationController
  def new
    if valid_credentials? == 'true'
      road_trip = RoadTripFacade.new(dir_params).road_trip
      binding.pry
      render json: RoadTripSerializer.new(fcast)
    end
  end

  private

  def valid_credentials?
    if User.find_by(api_key: params[:api_key]).nil?
      render json: {error: 'Invalid credentials'}, status: 401
    elsif params[:origin].empty?
      render json: {error: 'Origin cannot be blank'}, status: 400
    elsif params[:destination].empty?
      render json: {error: 'Destination cannot be blank'}, status: 400
    else
      'true'
    end
  end

  def dir_params
    params.permit(:origin, :destination)
  end
end
