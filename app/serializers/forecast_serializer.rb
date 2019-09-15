class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location, :conditions, :hourly_forecast, :daily_forecast
end
