ENV['RACK_ENV'] = 'test'
require_relative '../spec_helper'

describe "When user visits index" do
  describe "The user sees all of the data" do
    it "for one station " do
      Station.create(name: "Station Name",
                    city_id: City.find_or_create_by(name: "Denver").id,
                    dock_count: 15,
                    installation_date: "8/7/2016")

      visit('/stations')

      within("h1") do
        expect page.has_content?("Stations")
      end
      within("#station-name") do
        expect page.has_content?("Station Name")
      end
      within("#city") do
        expect page.has_content?("Denver")
      end
    end
  end

  describe "Has link" do
    it "to edit" do
      Station.create(name: "Station Name",
                    city_id: City.find_or_create_by(name: "Denver").id,
                    dock_count: 15,
                    installation_date: "8/7/2016")
      visit('/stations')

      expect(page).to have_link("Edit")
    end
  end

  describe "has button" do
    it "to delete" do
      Station.create(name: "Station Name",
                    city_id: City.find_or_create_by(name: "Denver").id,
                    dock_count: 15,
                    installation_date: "8/7/2016")
      visit('/stations')

      expect page.has_button?("Delete")
    end
  end
end
