require_relative '../spec_helper'

RSpec.describe City do
  describe 'validations' do
    it 'validates presence of name' do
      city = City.create()

      expect(city).to_not be_valid
    end

    it 'is valid with valid parameters' do
      city = City.create(name: "New Victoria")

      expect(city).to be_valid
    end

    it 'is not valid with duplicate entries' do
      city_1 = City.create(name: "New Victoria")
      city_2 = City.create(name: "New Victoria")

      expect(city_1).to be_valid
      expect(city_2).to_not be_valid
    end
  end
end