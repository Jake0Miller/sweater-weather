class CoordSerializer
  include FastJsonapi::ObjectSerializer
  attributes :lat, :long, :address, :id, :name
end
