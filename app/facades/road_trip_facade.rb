class RoadTripFacade
  attr_reader :id, :origin, :destination, :duration, :temperature, :summary
  @@id = 0

  def initialize(params)
    @@id += 1
    @id = @@id
    @origin = params[:origin].downcase
    @destination = params[:destination].downcase
    @duration = directions / 60
    @temperature, @summary = road_trip
  end

  def road_trip
    location = LocationFacade.new(@destination).location
    eta = directions + Time.now.to_i
    forecast = ForecastFacade.new(location, eta).forecast
    [forecast.currently[:temperature], forecast.currently[:summary]]
  end

  private

  def directions
    service.directions[:routes][0][:legs][0][:duration][:value]
  end

  def service
    @_service = Directions.new(@origin, @destination)
  end
end
