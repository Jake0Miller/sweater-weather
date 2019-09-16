class GifSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :description, :url
end
