ENV['RACK_ENV'] = 'test'
require_relative '../spec_helper'

describe "When user clicks the edit button" do
  it "They are taken to a new page" do
    Station.create(name: "Station Name",
                  city_id: City.find_or_create_by(name: "Denver").id,
                  dock_count: 15,
                  installation_date: "08/07/2016")

    visit('/stations')
    find_link("Edit").click

    expect page.has_current_path?('/stations/1/edit')
  end

  describe "They are able to fill out a form" do
    it "and update a station" do
      date = "01/27/2016 09:30"
      date2= "01/27/2016 09:32"

      Trip.create(duration: 145, start_date: Date.strptime(date, "%m/%d/%Y %H:%M"),
      start_station_id: 1, end_date: Date.strptime(date2, "%m/%d/%Y %H:%M"),
      end_station_id: 1, bike_id: 12, subscription_type: "Subscribed",
      zip_code: 80218)

      Station.create(name: "Station Name",
      city_id: City.create(name: "Denver").id,
      dock_count: 15,
      installation_date: "08/07/2016")

      station = Station.find(1)

      expect page.has_content?("Denver")

      fill_in('city[name]', :with => "Baltimore")
      click_button("Update Station")

      expect page.has_current_path?('/stations/1')
      expect page.has_content?("Baltimore")
    end
  end
end
