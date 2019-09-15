class LocationFacade
  def self.coords(location)
    db_location = Location.find_or_create_by(name: location)
    return db_location if db_location[:address]
    location = Geocoder.new(location).coords[:results]
    coords = location[0][:geometry][:location]
    coords[:address] = location[0][:formatted_address]
    db_location.update_attributes(coords)
    db_location
  end
end
