class CoordSerializer #< ActiveModel::Serializer
  include FastJsonapi::ObjectSerializer
  attributes :place_id, :lat, :long
end
