class Giphy < BaseService
  def gif(summary)
    get_json("v1/gifs/search?q=#{summary}")
  end

  private

  def conn
    @_conn ||= Faraday.new(url: "https://api.giphy.com/") do |faraday|
      faraday.params["api_key"] = ENV['gif_key']
      faraday.adapter Faraday.default_adapter
    end
  end
end
