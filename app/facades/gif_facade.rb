class GifFacade
  def initialize(forecast)
    @forecast = forecast.map {|fcast| {time: fcast[:time], summary: fcast[:summary]}}
  end

  def gifs
    # binding.pry
    @forecast.each do |forecast|
      forecast[:url] = gif(forecast)
    end
    @forecast
  end

  def gif(forecast)
    gif = Gif.find_or_create_by(description: forecast[:summary])
    return gif.url if gif && gif.url

  end

  private

  def service(summary)
    @_service ||= Giphy.new(summary).gif
  end
end
