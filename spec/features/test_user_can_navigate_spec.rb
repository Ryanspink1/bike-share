ENV['RACK_ENV'] = 'test'
require_relative '../spec_helper'

describe "When a user uses the nav bar" do
  describe "the user is guided" do
    it "to the home page" do
      visit('/')
      find_link("Home").click

      expect page.has_current_path?('/')
    end

    it "to the station index page" do
      visit('/')
      find_link("Station Index").click

      expect page.has_current_path?('/stations')
    end

    it "to the new station page" do
      visit('/')
      find_link("New Station").click

      expect page.has_current_path?('/stations/new')
    end

    it "to the station dashboard" do
      Station.create(name: "Name Station", city_id: City.create(name:"Denver").id, dock_count: 20, installation_date: "09/09/2016")

      visit('/')
      find_link("Station Dashboard").click

      expect page.has_current_path?('/station-dashboard')
    end

    it "to the trips index page" do
      visit('/')
      find_link("Trips Index").click

      expect page.has_current_path?('/trips')
    end

    it "to the new trip page" do
      visit('/')
      find_link("New Trip").click

      expect page.has_current_path?('/trips/new')
    end

    it "to the weather conditions page" do
      visit('/')
      find_link("Weather Conditions").click

      expect page.has_current_path?('/conditions')
    end

    it "to the new weather conditions page" do
      visit('/')
      find_link("Stations").click

      expect page.has_current_path?('/conditions/new')
    end

    it "to the weather dashboard" do
      visit('/')
      find_link("Stations").click

      expect page.has_current_path?('/weather-dashboard')
    end
  end
end
