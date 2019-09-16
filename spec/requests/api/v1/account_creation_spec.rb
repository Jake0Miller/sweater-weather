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
    user = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 201

    expect(user.length).to eq(1)
    expect(user.keys).to eq([:api_key])
    expect(user[:api_key].length).to eq(26)
    expect(User.first.api_key).to eq(user[:api_key])
  end
end
