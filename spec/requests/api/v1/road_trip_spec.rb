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

  it 'I ' do
    post '/api/v1/road_trip', params: @request_body.to_json, headers: @headers

    user = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 200

    expect(user.length).to eq(1)
    expect(user.keys).to eq([:api_key])
    expect(user[:api_key].length).to eq(26)
    expect(User.first.api_key).to eq(user[:api_key])
    expect(User.count).to eq(1)
  end

  it 'Email cannot be blank' do
    @request_body[:email] = ''
    post '/api/v1/road_trip', params: @request_body.to_json, headers: @headers

    user = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 401

    expect(user.length).to eq(1)
    expect(user.keys).to eq([:error])
    expect(user[:error]).to eq('Username/password do not match')
  end

  it 'Password cannot be blank' do
    @request_body[:password] = ''
    post '/api/v1/road_trip', params: @request_body.to_json, headers: @headers

    user = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 401

    expect(user.length).to eq(1)
    expect(user.keys).to eq([:error])
    expect(user[:error]).to eq('Username/password do not match')
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
