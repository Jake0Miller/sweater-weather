class Api::V1::GifsController < ApplicationController
  def index
    location = LocationFacade.new(params[:location]).location
    fcast = Rails.cache.fetch("forecasts/#{location}", expires_in: 1.minutes) do
      ForecastFacade.new(location).forecast
    end
    gifs = {data: {images: GifFacade.new(fcast.daily[:data][0..4]).gifs}}
    gifs[:copyright] = "2019"
    render json: gifs
  end
end
