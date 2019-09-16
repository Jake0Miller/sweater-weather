require 'rails_helper'

describe 'GET /api/v1/coordinates?location=denver,co' do
  before :each do
    stub_json("https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['key']}",
      "./fixtures/coords.json")
    stub_json("https://maps.googleapis.com/maps/api/geocode/json?address=denver,ia&key=#{ENV['key']}",
      "./fixtures/alt_coords.json")

    @headers = {'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'}

    expect(Location.count).to eq(0)

    get "/api/v1/coordinates?location=denver,co", headers: @headers
  end

  it 'I can get coordinates' do
    coords = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(response.status).to eq 200
    expect(Location.count).to eq(1)

    expect(coords[:lat]).to eq("39.7392358")
    expect(coords[:lng]).to eq("-104.990251")
    expect(coords[:address]).to eq("Denver, CO, USA")
    expect(coords[:name]).to eq("denver,co")
  end

  it 'Multiple queries do not make multiple api calls' do
    expect(response.status).to eq 200
    expect(Location.count).to eq(1)

    get "/api/v1/coordinates?location=denver,co", headers: @headers

    expect(response.status).to eq 200
    expect(Location.count).to eq(1)

    get "/api/v1/coordinates?location=denver,ia", headers: @headers

    expect(response.status).to eq 200
    expect(Location.count).to eq(2)
  end
end
