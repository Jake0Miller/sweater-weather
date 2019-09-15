class BackgroundFacede
  def self.image(location)
    db_location = Location.find_or_create_by(name: location)
    if db_location[:address] && db_location.image
      db_location.image
    else
      image = Background.new(location).image[:results][0][:urls]
      unless db_location[:address]
        location = Geocoder.new(location).coords[:results]
        coords = location[0][:geometry][:location]
        coords[:address] = location[0][:formatted_address]
        db_location.update_attributes(coords)
      end
      Image.create(image.merge(location: db_location))
    end
  end
end
