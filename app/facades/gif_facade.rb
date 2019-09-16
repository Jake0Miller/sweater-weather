class GifFacade
  def initialize(forecast)
    @forecast = forecast
  end

  def image
    db_location = LocationFacade.new(@location).location
    image = db_location.image
    return image if image
    image = service[:results][0][:urls]
    Image.create(image.merge(location: db_location))
  end

  private

  def service
    @_service ||= Background.new(@location).image
  end
end
