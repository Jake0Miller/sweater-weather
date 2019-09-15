class Api::V1::ForecastController < ApplicationController
  def show
    render json: ForecastFacade.forecast(params[:location])
  end
end
