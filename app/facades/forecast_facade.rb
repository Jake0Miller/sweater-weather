class ForecastFacade
  def self.forecast(location)
    coords = LocationFacade.coords(location)
    fc = DarkSky.new(coords).forecast

    {location: coords[:address],
    conditions: fc[:currently],
    hourly_forecast: fc[:hourly],
    daily_forecast: fc[:daily]}
  end
end
