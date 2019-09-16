class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :origin, :destination, :duration, :temperature, :summary
end
