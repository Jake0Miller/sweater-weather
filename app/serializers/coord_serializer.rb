class CoordSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :lat, :lng, :address, :name
end
