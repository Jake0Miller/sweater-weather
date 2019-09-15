require 'rails_helper'

describe 'GET /api/v1/coordinates?location=denver,co' do
  it 'I can get coordinates' do
    stub_json("https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['key']}",
      "./fixtures/coords.json")

    get "/api/v1/coordinates?location=denver,co"

    coords = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(response.status).to eq 200
    
    expect(coords[:lat]).to eq("39.7392358")
    expect(coords[:lng]).to eq("-104.990251")
    expect(coords[:address]).to eq("Denver, CO, USA")
    expect(coords[:name]).to eq("denver,co")
  end
end
