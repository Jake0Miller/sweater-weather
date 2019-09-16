class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :location, :address, :currently, :hourly, :daily
end
