class RoadTripFacade
  def initialize(params)
    @origin = params[:origin]
    @destination = params[:destination]
  end

  def directions
    service.directions[:routes][0][:legs][0][:duration][:value]
  end

  private

  def service
    @_service = Directions.new(@origin, @destination)
  end
end
