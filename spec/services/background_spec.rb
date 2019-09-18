require 'rails_helper'

describe Background do
	before :each do
    stub_json("https://maps.googleapis.com/maps/api/geocode/json?address=denver,co&key=#{ENV['key']}",
      "./fixtures/coords.json")
    stub_json("https://api.unsplash.com/search/photos?pages=1&per_page=1&query=denver,co,parks",
      "./fixtures/image.json")

		@background = Background.new('denver,co')
	end

  it "exists" do
		expect(@background).to be_a(Background)
  end

  it "returns an image" do
    image = @background.image
    expect(image).to be_a Hash
    expect(image.length).to eq(3)
    expect(image.keys).to eq([:total, :total_pages, :results])
  end
end
