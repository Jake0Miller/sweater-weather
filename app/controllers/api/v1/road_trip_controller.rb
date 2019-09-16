class Api::V1::RoadTripController < ApplicationController
  def new
    if valid_credentials? == 'true'
      # binding.pry
      directions = DirectionsFacade.new(params[:origin], params[:destination]).directions
      location = LocationFacade.new(params[:destination].downcase).location
      fcast = Rails.cache.fetch("forecasts/#{location}", expires_in: 10.minutes) do
        ForecastFacade.new(location).forecast
      end
      render json: ForecastSerializer.new(fcast)
    end
    # Time.now.to_i
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
end
