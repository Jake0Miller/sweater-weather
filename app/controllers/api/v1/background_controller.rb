class Api::V1::BackgroundController < ApplicationController
  def show
    render json: Background.new(params[:location]).image[:results][0][:urls]
  end
end
