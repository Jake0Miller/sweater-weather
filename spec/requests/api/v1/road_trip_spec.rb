require 'rails_helper'

describe 'POST /api/v1/road_trip' do
  before(:each) do
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
    expect(road_trip[:api_key].length).to eq(26)
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
