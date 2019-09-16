class GifFacade
  def initialize(forecast)
    @forecast = forecast.map {|fcast| {time: fcast[:time], summary: fcast[:summary]}}
  end

  def gifs
    @forecast.each do |forecast|
      forecast[:url] = gif(forecast[:summary])
    end
    @forecast
  end

  def gif(summary)
    gif = Gif.find_or_create_by(description: summary)
    return gif.url if gif && gif.url
    service(summary)
  end

  private

  def service(summary)
    @_service ||= Giphy.new.gif(summary)
  end
end
