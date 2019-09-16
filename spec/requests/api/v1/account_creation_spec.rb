require 'rails_helper'

describe 'POST /api/v1/users' do
  before(:each) do
    @request_body = {"email" => "whatever@example.com",
      "password" => "password",
      "password_confirmation" => "password"}
    @headers = {'CONTENT_TYPE' => 'application/json',
      'ACCEPT' => 'application/json'}
  end

  it 'I can create a new user and receive an api key' do
    expect(User.count).to eq(0)

    post '/api/v1/users', params: @request_body.to_json, headers: @headers

    user = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 201

    expect(user.length).to eq(1)
    expect(user.keys).to eq([:api_key])
    expect(user[:api_key].length).to eq(26)
    expect(User.first.api_key).to eq(user[:api_key])
    expect(User.count).to eq(1)
  end

  it 'Email cannot be blank' do
    @request_body[:email] = ''
    post '/api/v1/users', params: @request_body.to_json, headers: @headers

    user = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 400

    expect(user.length).to eq(1)
    expect(user.keys).to eq([:error])
    expect(user[:error]).to eq("Email can't be blank")
    expect(User.count).to eq(0)
  end

  it 'Password cannot be blank' do
    @request_body[:password] = ''
    post '/api/v1/users', params: @request_body.to_json, headers: @headers

    user = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 400

    expect(user.length).to eq(1)
    expect(user.keys).to eq([:error])
    expect(user[:error]).to eq("Password can't be blank")
    expect(User.count).to eq(0)
  end

  it 'Passwords must match' do
    @request_body[:password] = 'frogs'
    post '/api/v1/users', params: @request_body.to_json, headers: @headers

    user = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq 400

    expect(user.length).to eq(1)
    expect(user.keys).to eq([:error])
    expect(user[:error]).to eq("Password confirmation doesn't match Password")
    expect(User.count).to eq(0)
  end
end
