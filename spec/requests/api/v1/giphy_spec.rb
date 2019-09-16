require 'rails_helper'

describe 'GET /api/v1/gifs?location=denver,co' do
  it 'I can get a gif' do
    stub_json("https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['key']}",
      "./fixtures/coords.json")
    stub_json("https://api.darksky.net/forecast/#{ENV['dark_sky']}/39.7392358,-104.990251",
      "./fixtures/forecast.json")

    headers = {'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'}

    expect(Location.count).to eq(0)

    get "/api/v1/gifs?location=denver,co", headers: headers

    gifs = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 200

    expect(gifs.length).to eq(2)
    expect(gifs.keys).to eq([:data, :copyright])
    expect(gifs[:copyright]).to eq("2019")
    expect(gifs[:data].length).to eq(5)
    expect(gifs[:data].first.keys).to eq([:time, :summary, :url])
  end
end
