require 'rails_helper'

describe 'GET /api/v1/forecast?location=denver,co' do
  it 'I can get a forecast' do
    stub_json("https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['key']}",
      "./fixtures/coords.json")
    stub_json("https://api.darksky.net/forecast/#{ENV['dark_sky']}/39.7392358,-104.990251",
      "./fixtures/forecast.json")

    headers = {'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'}

    expect(Location.count).to eq(0)

    get "/api/v1/forecast?location=denver,co", headers: headers

    forecast = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(response.status).to eq 200

    expect(forecast.length).to eq(6)
    expect(forecast.keys).to eq([:id, :location, :address, :currently, :hourly, :daily])
    expect(forecast[:address]).to eq("Denver, CO, USA")
    expect(forecast[:currently][:summary]).to eq("Partly Cloudy")
  end
end
