class Geocoder < BaseService
  def initialize(location)
    @location = location
  end

  def coords
    get_json("maps/api/geocode/json")
  end

  private

  def conn
    @_conn ||= Faraday.new(url: "https://maps.googleapis.com/") do |faraday|
      faraday.params["key"] = ENV['key']
      faraday.params["address"] = @location
      faraday.adapter Faraday.default_adapter
    end
  end
end
