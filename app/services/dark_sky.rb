class DarkSky < BaseService
  def initialize(coords, eta)
    @lat = coords[:lat]
    @long = coords[:lng]
    @eta = eta
  end

  def forecast
    get_json("forecast/#{ENV['dark_sky']}/#{@lat},#{@long}#{set_time}")
  end

  private

  def conn
    @_conn ||= Faraday.new(url: "https://api.darksky.net/") do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def set_time
    @eta == '' ? '' : ',' + @eta.to_s
  end
end
