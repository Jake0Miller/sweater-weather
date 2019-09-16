class RoadTripFacade
  def initialize(params)
    @origin = params[:origin]
    @destination = params[:destination]
  end

  def road_trip
    duration = RoadTripFacade.new(dir_params).directions
    eta = duration + Time.now.to_i
    location = LocationFacade.new(params[:destination].downcase).location
    ForecastFacade.new(location, eta).forecast
  end

  private

  def directions
    service.directions[:routes][0][:legs][0][:duration][:value]
  end

  def service
    @_service = Directions.new(@origin, @destination)
  end
end
