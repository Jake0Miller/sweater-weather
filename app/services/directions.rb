class Directions < BaseService
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def directions
    get_json("maps/api/directions/json")
  end

  private

  def conn
    @_conn ||= Faraday.new(url: "https://maps.googleapis.com/") do |faraday|
      faraday.params["key"] = ENV['map_key']
      faraday.params["origin"] = @origin
      faraday.params["destination"] = @destination
      faraday.adapter Faraday.default_adapter
    end
  end
end
