class Forecast
  attr_reader :id, :location, :address, :conditions, :hourly, :daily

  def initialize(params)
    @id = rand(1..100)
    @location = params[:location]
    @address = params[:address]
    @conditions = params[:conditions]
    @hourly = params[:hourly]
    @daily = params[:daily]
  end
end
