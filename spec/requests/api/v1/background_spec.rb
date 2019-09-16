require 'rails_helper'

describe 'GET /api/v1/backgrounds?location=denver,co' do
  before :each do
    stub_json("https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['key']}",
      "./fixtures/coords.json")
    stub_json("https://maps.googleapis.com/maps/api/geocode/json?address=denver,ia&key=#{ENV['key']}",
      "./fixtures/alt_coords.json")
    stub_json("https://api.unsplash.com/search/photos?pages=1&per_page=1&query=denver,co",
      "./fixtures/image.json")
    stub_json("https://api.unsplash.com/search/photos?pages=1&per_page=1&query=denver,ia",
      "./fixtures/alt_image.json")

    @headers = {'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'}

    expect(Image.count).to eq(0)
    expect(Location.count).to eq(0)

    get "/api/v1/backgrounds?location=denver,co", headers: @headers
  end

  it 'I can get a background picture' do
    image = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(response.status).to eq 200
    expect(Image.count).to eq(1)
    expect(Location.count).to eq(1)

    expect(image[:raw]).to eq("https://images.unsplash.com/photo-1507070908536-ff515fea8402?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjkxNTc0fQ")
    expect(image.keys).to include(:raw, :full, :regular, :small, :thumb)

    get "/api/v1/backgrounds?location=denver,co"
  end

  it 'Multiple queries do not make multiple api calls' do
    expect(response.status).to eq 200
    expect(Image.count).to eq(1)
    expect(Location.count).to eq(1)

    get "/api/v1/backgrounds?location=denver,co", headers: @headers

    expect(response.status).to eq 200
    expect(Image.count).to eq(1)
    expect(Location.count).to eq(1)

    get "/api/v1/backgrounds?location=denver,ia", headers: @headers

    expect(response.status).to eq 200
    expect(Image.count).to eq(2)
    expect(Location.count).to eq(2)

    image = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(image.keys).to include(:raw, :full, :regular, :small, :thumb)
  end
end
