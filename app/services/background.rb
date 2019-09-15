class Background
  def initialize(location)
    @location = location
  end

  def image
    get_json("search/photos")
  end

  private

  def conn
    @_conn ||= Faraday.new(url: "https://api.unsplash.com/") do |faraday|
      faraday.headers["Authorization"] = "Client-ID #{ENV['key']}"
      faraday.params["query"] = @location
      faraday.params["per_page"] = "1"
      faraday.params["pages"] = "1"
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
