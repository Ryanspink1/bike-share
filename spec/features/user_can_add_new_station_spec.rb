ENV['RACK_ENV'] = 'test'
require_relative '../spec_helper'

describe "When a user submits a form for a new station" do
  it "A new station object is created" do
    date = "01/27/2016 09:30"
    date2= "01/27/2016 09:32"

    Trip.create(duration: 145, start_date: Date.strptime(date, "%m/%d/%Y %H:%M"),
      start_station_id: 1, end_date: Date.strptime(date2, "%m/%d/%Y %H:%M"),
    end_station_id: 1, bike_id: 12, subscription_type: "Subscribed",
    zip_code: 80218)
    visit ('/stations/new')

    fill_in('station[name]', :with => 'Beat Street')
    fill_in('city[name]', :with => 'Denver')
    fill_in('station[dock_count]', :with => 10)
    fill_in('station[installation_date]', :with => '20170102')
    click_button("New Station")

    # binding.pry
    expect(Station.find(1)).to be_valid
    end
end

describe "When a user submits a form for a new station" do
  it "User is directed to /show page" do
    date = "01/27/2016 09:30"
    date2= "01/27/2016 09:32"

    Trip.create(duration: 145, start_date: Date.strptime(date, "%m/%d/%Y %H:%M"),
    start_station_id: 1, end_date: Date.strptime(date2, "%m/%d/%Y %H:%M"),
    end_station_id: 1, bike_id: 12, subscription_type: "Subscribed",
    zip_code: 80218)
    visit ('/stations/new')

    fill_in('station[name]', :with => 'Beat Street')
    fill_in('city[name]', :with => 'Denver')
    fill_in('station[dock_count]', :with => '10')
    fill_in('station[installation_date]', :with => '20170102')
    click_button("New Station")

    expect page.has_current_path?('/stations/1')
  end
end
# rake db:test:prepare
# rspec ./spec/features/user_can_add_new_station.rb
