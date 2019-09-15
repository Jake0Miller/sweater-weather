require 'rails_helper'

describe 'GET /api/v1/forecast?location=denver,co' do
  it 'I can get a forecast' do
    stub_json("https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['key']}",
      "./fixtures/coords.json")
    stub_json("https://api.darksky.net/forecast/#{ENV['dark_sky']}/39.7392358,-104.990251",
      "./fixtures/forecast.json")

    get "/api/v1/forecast?location=denver,co"

    forecast = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 200
    
    expect(forecast.length).to eq(4)
    expect(forecast.keys).to eq([:location, :conditions, :hourly_forecast, :daily_forecast])
    expect(forecast[:location]).to eq("Denver, CO, USA")
  end
end
