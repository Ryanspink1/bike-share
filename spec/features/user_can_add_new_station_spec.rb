ENV['RACK_ENV'] = 'test'
require_relative '../spec_helper'

describe "When a user submits a form for a new station" do
  it "A new station object is created" do
    visit ('/stations/new')

    fill_in('station[name]', :with => 'Beat Street')
    fill_in('city[name]', :with => 'Denver')
    fill_in('station[dock_count]', :with => '10')
    fill_in('station[installation_date]', :with => '20170102')
    click_button("Create New Station")
    expect(Station.find(1)).to be_valid
    end
end

describe "When a user submits a form for a new station" do
  it "User is directed to /show page" do
    visit ('/stations/new')

    fill_in('station[name]', :with => 'Beat Street')
    fill_in('city[name]', :with => 'Denver')
    fill_in('station[dock_count]', :with => '10')
    fill_in('station[installation_date]', :with => '20170102')
    click_button("Create New Station")
    expect page.has_current_path?('/stations/1/show')
  end
end
# rake db:test:prepare
# rspec ./spec/features/user_can_add_new_station.rb
