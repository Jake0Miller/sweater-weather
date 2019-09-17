require 'rails_helper'

describe Geocoder do
	before :each do
    stub_json("https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['key']}",
      "./fixtures/coords.json")

    @geocoder = Geocoder.new('denver,co')
	end

  it "exists" do
		expect(@geocoder).to be_a(Geocoder)
  end

  it "returns a location" do
    location = @geocoder.coords
    expect(location).to be_a Hash
    expect(location.length).to eq(2)
    expect(location.keys).to eq([:results, :status])
  end
end
