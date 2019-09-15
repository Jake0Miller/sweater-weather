require 'rails_helper'

RSpec.describe Image, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :raw}
    it {should validate_presence_of :full}
    it {should validate_presence_of :regular}
    it {should validate_presence_of :small}
    it {should validate_presence_of :thumb}
  end

  describe 'Relationships' do
    it {should belong_to :location}
  end
end
