require 'rails_helper'
require 'time'

describe 'POST /api/v1/road_trip' do
  before(:each) do
    stub_json("https://maps.googleapis.com/maps/api/geocode/json?address=pueblo,co&key=#{ENV['key']}",
      "./fixtures/pueblo_coords.json")
    stub_json("https://maps.googleapis.com/maps/api/directions/json?origin=denver,co&destination=pueblo,co&key=#{ENV['map_key']}",
      "./fixtures/denver_to_pueblo.json")
    stub_json("https://api.darksky.net/forecast/#{ENV['dark_sky']}/38.2544472,-104.6091409,1568662126",
      "./fixtures/pueblo_forecast.json")

    allow(Time).to receive(:now).and_return(Time.parse("2019-09-16 11:42:23 -0600"))

    @user = User.create!(email: 'whatever@example.com', password: 'password', api_key: SecureRandom.hex(13))

    @request_body = {origin: "Denver,CO",
      destination: "Pueblo,CO",
      api_key: @user.api_key}

    @headers = {'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'}
  end

  it 'I see the advance forceast and travel time' do
    expect(Location.count).to eq (0)

    post '/api/v1/road_trip', params: @request_body.to_json, headers: @headers

    road_trip = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response.status).to eq 200

    expect(road_trip.keys).to eq([:id, :type, :attributes])
    expect(road_trip[:attributes].keys).to eq([:id, :origin, :destination, :duration, :temperature, :summary])
    expect(road_trip[:attributes][:temperature]).to eq(85.5)

    expect(Location.count).to eq (1)
  end

  it 'Origin cannot be blank' do
    @request_body[:origin] = ''

    post '/api/v1/road_trip', params: @request_body.to_json, headers: @headers

    user = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 400

    expect(user.keys).to eq([:error])
    expect(user[:error]).to eq('Origin cannot be blank')
  end

  it 'Destination cannot be blank' do
    @request_body[:destination] = ''

    post '/api/v1/road_trip', params: @request_body.to_json, headers: @headers

    user = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 400

    expect(user.keys).to eq([:error])
    expect(user[:error]).to eq('Destination cannot be blank')
  end

  it 'Api key cannot be blank' do
    @request_body[:api_key] = ''

    post '/api/v1/road_trip', params: @request_body.to_json, headers: @headers

    user = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 401

    expect(user.keys).to eq([:error])
    expect(user[:error]).to eq('Invalid credentials')
  end
end
