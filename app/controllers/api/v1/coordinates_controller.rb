class Api::V1::CoordinatesController < ApplicationController
  def show
    render json: LocationFacade.coords(params[:location])
  end
end
