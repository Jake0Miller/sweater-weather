class BackgroundSerializer
  include FastJsonapi::ObjectSerializer
  attributes :raw, :full, :regular, :small, :thumb
end
