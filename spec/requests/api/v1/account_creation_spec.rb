require 'rails_helper'

describe 'POST /api/v1/users' do
  before(:each) do
    request_body = {"email" => "whatever@example.com",
      "password" => "password",
      "password_confirmation" => "password"}
    headers = {'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'}
    post '/api/v1/users', params: request_body.to_json, headers: headers
  end

  it 'I can create a new user and receive an api key' do
    forecast = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(response.status).to eq 200

    expect(forecast.length).to eq(1)
    expect(forecast.keys).to eq([:api_key])
    expect(forecast[:api_key].length).to eq(27)
  end
end
