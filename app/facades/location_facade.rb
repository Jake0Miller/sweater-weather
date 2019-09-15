class LocationFacade
  def initialize(location)
    @location = location
  end

  def coordinates
    location = service.coords[:results]
    coords = location[0][:geometry][:location]
    coords[:address] = location[0][:formatted_address]
    coords
  end

  def location
    loc = Location.find_or_create_by(name: @location)
    loc.update_attributes(coordinates) if loc[:address].nil?
    loc
  end

  private

  def service
    @_service ||= Geocoder.new(@location)
  end
end
