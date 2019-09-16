class ImageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :raw, :full, :regular, :small, :thumb
end
