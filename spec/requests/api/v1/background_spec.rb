require 'rails_helper'

describe 'GET /api/v1/backgrounds?location=denver,co' do
  it 'I can get a background picture' do
    stub_json("https://api.unsplash.com/search/photos?pages=1&per_page=1&query=denver,co",
      "./fixtures/image.json")

    get "/api/v1/backgrounds?location=denver,co"

    image = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 200

    expect(image[:raw]).to eq("https://images.unsplash.com/photo-1507070908536-ff515fea8402?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjkxNTc0fQ")
    expect(image.keys).to eq([:raw, :full, :regular, :small, :thumb])
  end
end
