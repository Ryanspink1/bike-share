require_relative '../spec_helper'

RSpec.describe DockCount do
  describe 'validations' do
    it 'validates presence of dock_number' do
      dock_count = DockCount.create()

      expect(dock_count).to_not be_valid
    end

    it 'is valid with valid parameters' do
      dock_count = DockCount.create(dock_number: 10)

      expect(dock_count).to be_valid
    end

    it 'is not valid with duplicate entries' do
      dock_count_1 = DockCount.create(dock_number: 14)
      dock_count_2 = DockCount.create(dock_number: 14)

      expect(dock_count_1).to be_valid
      expect(dock_count_2).to_not be_valid
    end
  end
end