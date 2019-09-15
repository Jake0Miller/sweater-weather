class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :location, :address, :conditions, :hourly, :daily
end
