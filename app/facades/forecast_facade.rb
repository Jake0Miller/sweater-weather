class ForecastFacade
  def initialize(loc, eta = '')
    @loc = loc
    @eta = eta
  end

  def forecast
    Forecast.new(@loc, service)
  end

  private

  def service
    @_service = DarkSky.new(@loc, @eta).forecast
  end
end
