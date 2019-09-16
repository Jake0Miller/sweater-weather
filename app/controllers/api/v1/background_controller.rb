class Api::V1::BackgroundController < ApplicationController
  def show
    image = BackgroundFacede.new(params[:location]).image
    render json: ImageSerializer.new(image)
  end
end
