require 'rails_helper'

describe 'GET /api/v1/coordinates?location=denver,co' do
  it 'I can favorite an asteroid' do
    stub_json("https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['key']}",
      "./fixtures/coords.json")

    get "/api/v1/coordinates?location=denver,co"

    coords = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 200

    expected = {lat: 39.7392358, lng: -104.990251}
    
    expect(coords).to eq(expected)
  end
end
