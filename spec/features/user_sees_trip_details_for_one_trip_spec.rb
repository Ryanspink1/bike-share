require_relative '../spec_helper'

describe "When user goes to trip page" do
  it "they see all the details for that trip" do
    date = "01/27/2016 09:30"
    date2= "01/27/2016 09:32"
    Station.create(name: "Station Name",
                  city_id: City.create(name: "Denver").id,
                  dock_count: 15,
                  installation_date: "8/7/2016")

    Trip.create(duration: 145,
                start_date: Date.strptime(date, "%m/%d/%Y %H:%M"),
                start_station_id: 1,
                end_date: Date.strptime(date2, "%m/%d/%Y %H:%M"),
                end_station_id: 1,
                bike_id: 12,
                subscription_type: "Subscribed",
                zip_code: 80218)

    visit('/trips/1')

    within(".duration") do
      expect page.has_content?("145")
    end
    within(".start-date") do
      expect page.has_content?(date)
    end
    within(".start-station") do
      expect page.has_content?("Denver")
    end
    within(".end-date") do
      expect page.has_content?(date2)
    end
    within(".end-station") do
      expect page.has_content?("Denver")
    end
    within(".bike-id") do
      expect page.has_content?("12")
    end
    within(".subscription-type") do
      expect page.has_content?("Subscribed")
    end
    within(".zip-code") do
      expect page.has_content?("80218")
    end
  end
end
