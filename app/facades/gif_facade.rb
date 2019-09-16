class GifFacade
  def initialize(forecast)
    @forecast = forecast.map {|fcast| {time: fcast[:time], summary: fcast[:summary]}}
  end

  def gifs
    @forecast.each do |forecast|
      forecast[:url] = gif(forecast[:summary])
    end
    output = {data: {images: @forecast}}
    output[:copyright] = "2019"
    output
  end

  def gif(summary)
    gif = Gif.find_or_create_by(description: summary)
    return gif.url if gif.url
    gif.update_attributes(url: service(summary))
    gif.url
  end

  private

  def service(summary)
    @_service = Giphy.new.gif(summary)[:data][0][:url]
  end
end
