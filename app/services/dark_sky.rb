class DarkSky < BaseService
  def initialize(coords, eta)
    @lat = coords[:lat]
    @long = coords[:lng]
    @eta = set_time
  end

  def forecast
    get_json("forecast/#{ENV['dark_sky']}/#{@lat},#{@long}#{@eta}")
  end

  private

  def conn
    @_conn ||= Faraday.new(url: "https://api.darksky.net/") do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def set_time
    @eta.nil? ? '' : ',' + @eta
  end
end
