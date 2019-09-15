class DarkSky < BaseService
  def initialize(coords)
    @lat = coords[:lat]
    @long = coords[:lng]
  end

  def forecast
    get_json("forecast/#{ENV['dark_sky']}/#{@lat},#{@long}")
  end

  private

  def conn
    @_conn ||= Faraday.new(url: "https://api.darksky.net/") do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end
end
