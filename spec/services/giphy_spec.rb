require 'rails_helper'

describe Giphy do
	before :each do
    stub_json("https://api.giphy.com/v1/gifs/search?api_key=#{ENV['gif_key']}&q=Mostly%20cloudy%20throughout%20the%20day.",
      "./fixtures/mostly_cloudy_gif.json")

		@giphy = Giphy.new
	end

  it "exists" do
		expect(@giphy).to be_a(Giphy)
  end

  it "returns gifs" do
    gifs = @giphy.gif('Mostly cloudy throughout the day.')
    expect(gifs).to be_a Hash
    expect(gifs.length).to eq(3)
    expect(gifs.keys).to eq([:data, :pagination, :meta])
  end
end
