require 'rails_helper'

describe Directions do
	before :each do
    stub_json("https://maps.googleapis.com/maps/api/directions/json?origin=denver,co&destination=pueblo,co&key=#{ENV['map_key']}",
      "./fixtures/denver_to_pueblo.json")

    @directions = Directions.new('denver,co', 'pueblo,co')
	end

  it "exists" do
		expect(@directions).to be_a(Directions)
  end

  it "returns directions" do
    directions = @directions.directions
    expect(directions).to be_a Hash
    expect(directions.length).to eq(3)
    expect(directions.keys).to eq([:geocoded_waypoints, :routes, :status])
  end
end
