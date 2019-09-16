class Api::V1::ForecastController < ApplicationController
  def show
    location = LocationFacade.new(params[:location].downcase).location
    fcast = Rails.cache.fetch("forecasts/#{location}", expires_in: 1.minutes) do
      ForecastFacade.new(location).forecast
    end
    render json: ForecastSerializer.new(fcast)
  end
end
