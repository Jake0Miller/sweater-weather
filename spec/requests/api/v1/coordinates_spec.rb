require 'rails_helper'

describe 'GET /api/v1/coordinates?location=denver,co' do
  it 'I can favorite an asteroid' do
    stub_json("https://maps.googleapis.com/maps/api/geocode/json", "./fixtures/coords.json")

    get "/api/v1/coordinates?location=denver,co"

    JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 200

    coords = [39.7392, -104.9903]
    coords.flatten

    expect(response[:id] == Favorite.last.id)
    expect(response[:neo_reference_id] == "2021277")
    expect(response[:user_id] == user.id)

    expected = {'name': '21277 (1996 TO5)', 'is_potentially_hazardous_asteroid': false}
    expect(response[:asteroid] == expected)
  end
end
