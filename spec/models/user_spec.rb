require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :email}
    it {should validate_presence_of :api_key}
    it {should validate_uniqueness_of(:email).case_insensitive}
  end
end
