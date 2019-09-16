require 'rails_helper'

RSpec.describe Gif, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :description}
    it {should validate_presence_of :url}
  end
end
