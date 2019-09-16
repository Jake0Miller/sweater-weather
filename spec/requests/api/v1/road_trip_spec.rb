require 'rails_helper'

describe 'POST /api/v1/road_trip' do
  before(:each) do
    stub_json("https://maps.googleapis.com/maps/api/geocode/json?address=pueblo,co&key=#{ENV['key']}",
      "./fixtures/pueblo_coords.json")
    stub_json("https://maps.googleapis.com/maps/api/directions/json?origin=Denver,CO&destination=Pueblo,CO&key=#{ENV['map_key']}",
      "./fixtures/denver_to_pueblo.json")
    stub_json("https://api.darksky.net/forecast/#{ENV['dark_sky']}/39.7392358,-104.990251",
      "./fixtures/forecast.json")

    @user = User.create!(email: 'whatever@example.com', password: 'password', api_key: SecureRandom.hex(13))

    @request_body = {"origin" => "Denver, CO",
      "destination" => "Pueblo, CO",
      "api_key" => @user.api_key}

    @headers = {'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'}
  end

  it 'I see the advance forceast and travel time' do
    post '/api/v1/road_trip', params: @request_body.to_json, headers: @headers

    road_trip = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 200

    expect(road_trip.length).to eq(1)
    expect(road_trip.keys).to eq([:api_key])
  end

  it 'Origin cannot be blank' do
    @request_body[:email] = ''
    post '/api/v1/road_trip', params: @request_body.to_json, headers: @headers

    user = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 400

    expect(user.keys).to eq([:error])
    expect(user[:error]).to eq('Origin cannot be blank')
  end

  it 'Destination cannot be blank' do
    @request_body[:password] = ''
    post '/api/v1/road_trip', params: @request_body.to_json, headers: @headers

    user = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 400

    expect(user.keys).to eq([:error])
    expect(user[:error]).to eq('Destination cannot be blank')
  end

  it 'Api key cannot be blank' do
    @request_body["api_key"] = ''
    post '/api/v1/road_trip', params: @request_body.to_json, headers: @headers

    user = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 401

    expect(user.keys).to eq([:error])
    expect(user[:error]).to eq('Invalid credentials')
  end
end
