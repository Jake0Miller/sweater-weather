class Geocoder
  def initialize(city, state)
    @city = city
    @state = state
  end

  def coords
    get_json("maps/api/geocode/json")
  end

  private

  def conn
    @_conn ||= Faraday.new(url: "https://maps.googleapis.com/") do |faraday|
      faraday.params["key"] = ENV['key']
      faraday.params["address"] = [@city.join("+"), @state].join(",+")
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
