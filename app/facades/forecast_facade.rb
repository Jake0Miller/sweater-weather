class ForecastFacade
  def initialize(loc)
    @loc = loc
  end

  def forecast
    fc = service

    params = {location: @loc,
      address: @loc[:address],
      conditions: fc[:currently],
      hourly: fc[:hourly],
      daily: fc[:daily]}

    Forecast.new(params)
  end

  private

  def service
    @_service ||= DarkSky.new(@loc).forecast
  end
end
