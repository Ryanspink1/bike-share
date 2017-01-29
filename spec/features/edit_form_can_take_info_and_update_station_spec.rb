require_relative '../spec_helper'

describe "When user clicks the edit button" do
  it "They are taken to a new page" do
    Station.create(name: "Station Name",
                  city_id: City.find_or_create_by(name: "Denver").id,
                  dock_count_id: DockCount.find_or_create_by(dock_number: 15).id,
                  installation_date_id: InstallationDate.find_or_create_by(installation_date: "8/7/2016").id)

    visit('/stations')
    find_link("Edit").click

    expect page.has_current_path?('/stations/1/edit')
  end

  describe "They are able to fill out a form" do
    it "and update a station" do
      Station.create(name: "Station Name",
                    city_id: City.find_or_create_by(name: "Denver").id,
                    dock_count_id: DockCount.find_or_create_by(dock_number: 15).id,
                    installation_date_id: InstallationDate.find_or_create_by(installation_date: '20090712').id)

      station = Station.find(1)

      expect(station.city.name).to eq("Denver")

      fill_in('city[name]', :with => "Baltimore")
      click_button("Update Station")

      station = Station.find(1)

      expect(station.city.name).to eq("Baltimore")
    end
  end
end
