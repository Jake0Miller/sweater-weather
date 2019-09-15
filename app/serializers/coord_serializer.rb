class CoordSerializer
  include FastJsonapi::ObjectSerializer
  attributes :lat, :lng, :address, :id, :name
end
