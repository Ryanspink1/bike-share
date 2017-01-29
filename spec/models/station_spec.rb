require_relative '../spec_helper'

RSpec.describe Station do
  describe 'validations' do
    it 'validates presence of name' do
      supporting_info

      station = Station.create(
        city: City.find(1),
        dock_count: DockCount.find(1),
        installation_date: InstallationDate.find(1)
      )

      expect(station).to_not be_valid
    end

    it 'validates presence of city' do
      supporting_info

      station = Station.create(
        name: "Blick & Lock",
        dock_count: DockCount.find(1),
        installation_date: InstallationDate.find(1)
      )

      expect(station).to_not be_valid
    end

    it 'validates presence of dock_count' do
      supporting_info

      station = Station.create(
        name: "Blick & Lock",
        city: City.find(1),
        installation_date: InstallationDate.find(1)
      )

      expect(station).to_not be_valid
    end

    it 'validates presence of installation_date' do
      supporting_info

      station = Station.create(
        name: "Blick & Lock",
        city: City.find(1),
        dock_count: DockCount.find(1)
      )

      expect(station).to_not be_valid
    end

    it 'is valid with valid parameters' do
      supporting_info

      station = Station.create(
        name: "Blick & Lock",
        city: City.find(1),
        dock_count: DockCount.find(1),
        installation_date: InstallationDate.find(1)
      )

      binding.pry

      expect(station).to be_valid
    end
  end
end

def supporting_info
    City.create(name: "New Victoria")
    DockCount.create(dock_number: 1)
    InstallationDate.create(installation_date: "1/1/2017")
end