class Forecast
  attr_reader :id, :location, :address, :currently, :hourly, :daily
  @@id = 0

  def initialize(location, forecast)
    @@id += 1
    @id = @@id
    @location = location
    @address = location[:address]
    @currently = forecast[:currently]
    @hourly = forecast[:hourly]
    @daily = forecast[:daily]
  end
end
