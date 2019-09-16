class DirectionsFacade
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def directions
    service.directions
  end

  private

  def service
    @_service = Directions.new(@origin, @destination)
  end
end
