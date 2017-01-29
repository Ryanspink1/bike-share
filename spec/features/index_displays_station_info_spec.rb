require_relative '../spec_helper'

describe "When user visits index" do
  describe "The user sees all of the data" do
    it "for one station " do
      Station.create(name: "Station Name",
                    city_id: City.find_or_create_by(name: "Denver").id,
                    dock_count_id: DockCount.find_or_create_by(dock_number: 15).id,
                    installation_date_id: InstallationDate.find_or_create_by(installation_date: 20100102).id)

      visit('/stations')

      within("h1") do
        expect page.has_content?("Stations")
      end
      within("h3") do
        expect page.has_content?("Station Name")
      end
      within(".city") do
        expect page.has_content?("Denver")
      end
    end
  end

  describe "Has link" do
    it "to edit" do
      Station.create(name: "Station Name",
                    city_id: City.find_or_create_by(name: "Denver").id,
                    dock_count_id: DockCount.find_or_create_by(dock_number: 15).id,
                    installation_date_id: InstallationDate.find_or_create_by(installation_date: "8/7/2016").id)
      visit('/stations')

      expect(page).to have_link("Edit")
    end
  end

  describe "has button" do
    it "to delete" do
      Station.create(name: "Station Name",
                    city_id: City.find_or_create_by(name: "Denver").id,
                    dock_count_id: DockCount.find_or_create_by(dock_number: 15).id,
                    installation_date_id: InstallationDate.find_or_create_by(installation_date: "8/7/2016").id)
      visit('/stations')

      expect page.has_button?("Delete")
    end
  end
end
