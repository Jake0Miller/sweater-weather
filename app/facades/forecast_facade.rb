class ForecastFacade
  def initialize(loc)
    @loc = loc
  end

  def forecast
    Forecast.new(@loc, service)
  end

  private

  def service
    @_service ||= DarkSky.new(@loc).forecast
  end
end
