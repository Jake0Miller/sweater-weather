require 'rails_helper'

describe 'GET /api/v1/gifs?location=denver,co' do
  it 'I can get a gif' do
    stub_json("https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['key']}",
      "./fixtures/coords.json")
    stub_json("https://api.darksky.net/forecast/#{ENV['dark_sky']}/39.7392358,-104.990251",
      "./fixtures/forecast.json")
    stub_json("https://api.giphy.com/v1/gifs/search?api_key=#{ENV['gif_key']}&q=Partly%20cloudy%20throughout%20the%20day.",
      "./fixtures/partly_cloudy_gif.json")

    headers = {'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'}

    expect(Location.count).to eq(0)

    get "/api/v1/gifs?location=denver,co", headers: headers

    gifs = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 200
    
    expect(gifs.length).to eq(2)
    expect(gifs.keys).to eq([:data, :copyright])
    expect(gifs[:copyright]).to eq("2019")
    expect(gifs[:data][:images].length).to eq(5)
    expect(gifs[:data][:images].first.keys).to eq([:time, :summary, :url])

    expect(gifs[:data][:images][0][:summary]).to eq("Partly cloudy throughout the day.")
    expect(gifs[:data][:images][1][:summary]).to eq("Mostly cloudy throughout the day.")
    expect(gifs[:data][:images][2][:summary]).to eq("Partly cloudy throughout the day.")
    expect(gifs[:data][:images][3][:summary]).to eq("Partly cloudy throughout the day.")
    expect(gifs[:data][:images][4][:summary]).to eq("Partly cloudy throughout the day.")

    expect(gifs[:data][:images][0][:url]).to eq("https://giphy.com/gifs/beach-clouds-aQ7kognlRPDzi")
    expect(gifs[:data][:images][1][:url]).to_not eq("https://giphy.com/gifs/beach-clouds-aQ7kognlRPDzi")
    expect(gifs[:data][:images][2][:url]).to eq("https://giphy.com/gifs/beach-clouds-aQ7kognlRPDzi")
    expect(gifs[:data][:images][3][:url]).to eq("https://giphy.com/gifs/beach-clouds-aQ7kognlRPDzi")
    expect(gifs[:data][:images][4][:url]).to eq("https://giphy.com/gifs/beach-clouds-aQ7kognlRPDzi")

    expect(Location.count).to eq(1)
    expect(Gif.count).to eq(2)
  end
end
