require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :lat}
    it {should validate_presence_of :lng}
  end

  describe 'Relationships' do
    # it {should belong_to :merchant}
    # it {should have_many :invoice_items}
  end
end
