require 'rails_helper'

describe DarkSky do
	before :each do
    stub_json("https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['key']}",
      "./fixtures/coords.json")
    stub_json("https://api.darksky.net/forecast/#{ENV['dark_sky']}/39.7392358,-104.990251",
      "./fixtures/forecast.json")

    coords = {lat: "39.7392358", lng: "-104.990251"}

		@dark_sky = DarkSky.new(coords, '')
	end

  it "exists" do
		expect(@dark_sky).to be_a(DarkSky)
  end

  it "returns a forecast" do
    forecast = @dark_sky.forecast
    expect(forecast).to be_a Hash
    expect(forecast.length).to eq(9)
  end
end
