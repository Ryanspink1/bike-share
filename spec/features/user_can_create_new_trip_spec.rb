require_relative '../spec_helper'

describe "When user submits a form" do
  it "they are able to create a new trip" do
    Station.create(name: "Station Name",
                  city_id: City.find_or_create_by(name: "Denver").id,
                  dock_count: 15,
                  installation_date: "8/7/2016")

    visit('/trips/new')

    select("Station Name", from: 'trip[start_station_id]')
    select("Station Name", from: 'trip[end_station_id]')
    fill_in('trip[duration]', :with => 100)
    fill_in('trip[start_date]', :with => '01/02/2017 09:30:50')
    fill_in('trip[end_date]', :with => '01/02/2017 09:32:50')
    fill_in('trip[bike_id]', :with => 12)
    select("Customer", from: 'trip[subscription_type]')
    fill_in('trip[zip_code]', :with =>80218)

    click_button("Create New Trip")
    expect page.has_current_path?('/trips/1')

    within(".duration") do
      expect page.has_content?("100")
    end
    within(".start-date") do
      expect page.has_content?('01/01/2017 09:30')
    end
    within(".start-station") do
      expect page.has_content?("Denver")
    end
    within(".end-date") do
      expect page.has_content?('01/02/2017 09:32')
    end
    within(".end-station") do
      expect page.has_content?("Denver")
    end
    within(".bike-id") do
      expect page.has_content?("12")
    end
    within(".subscription-type") do
      expect page.has_content?("Customer")
    end
    within(".zip-code") do
      expect page.has_content?("80218")
    end
  end
end
