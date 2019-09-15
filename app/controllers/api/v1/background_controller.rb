class Api::V1::BackgroundController < ApplicationController
  def show
    image = BackgroundFacede.image(params[:location])
    render json: ImageSerializer.new(image)
  end
end
