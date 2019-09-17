require 'rails_helper'

describe 'POST /api/v1/sessions' do
  before(:each) do
    @user = User.create!(email: 'whatever@example.com', password: 'password', api_key: SecureRandom.hex(13))

    @request_body = {"email" => @user.email,
      "password" => "password"}

    @headers = {'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'}
    expect(User.count).to eq(1)
  end

  it 'I can create a new user and receive an api key' do
    post '/api/v1/sessions', params: @request_body.to_json, headers: @headers

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
    post '/api/v1/sessions', params: @request_body.to_json, headers: @headers

    user = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 401

    expect(user.length).to eq(1)
    expect(user.keys).to eq([:error])
    expect(user[:error]).to eq('Username/password do not match')
  end

  it 'Password cannot be blank' do
    @request_body[:password] = ''
    post '/api/v1/sessions', params: @request_body.to_json, headers: @headers

    user = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 401

    expect(user.length).to eq(1)
    expect(user.keys).to eq([:error])
    expect(user[:error]).to eq('Username/password do not match')
  end
end
