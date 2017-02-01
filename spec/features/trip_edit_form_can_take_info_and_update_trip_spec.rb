ENV["RACK_ENV"] = "test"
require_relative "../spec_helper"

describe "when user clicks the 'Edit' button on the trip index page..." do
  it "they are taken to a new page" do
    setup

    visit("/trips")
    first(:link, "Edit").click

    expect page.has_current_path?("/trips/1/edit")
  end

  describe "the user is able to fill out the edit form..." do
    it "and update the start station" do
      setup
      visit("/trips")
      first(:link, "Edit").click

      trip = Trip.find(2)

      expect(trip.start_station.name).to eq("New Victoria St")

      select("West Earl Ave", :from => "trip[start_station_id]")
      click_button("Submit")

      trip.reload

      expect(trip.start_station.name).to eq("West Earl Ave")
      expect page.has_current_path?("/trips/1/")
    end

    it "and update the end station" do
      setup
      visit("/trips")
      first(:link, "Edit").click
      trip = Trip.find(2)

      expect(trip.start_station.name).to eq("New Victoria St")

      select("West Earl Ave", :from => "trip[end_station_id]")
      click_button("Submit")

      trip.reload

      expect(trip.end_station.name).to eq("West Earl Ave")
      expect page.has_current_path?("/trips/2/")
    end

    describe "and update the start date" do
      it "" do
        setup
        visit("/trips")
        first(:link, "Edit").click
        trip = Trip.find(1)

        expect(trip.formatted_start_date).to eq("01/01/2017 11:10:00")

        fill_in("trip[start_date]", :with => "01/01/2017 11:11:00")
        click_button("Submit")

        expect page.has_content?("01/01/2017 11:11:00")
      end

      it "... which automatically updates the duration" do
        setup
        visit("/trips")
        first(:link, "Edit").click
        trip = Trip.find(1)

        expect(trip.duration).to eq(300)
        expect(trip.formatted_end_date).to eq("01/01/2017 11:15:00")

        fill_in("trip[start_date]", :with => "01/01/2017 11:11:00")
        fill_in("trip[end_date]", :with => trip.formatted_end_date)
        click_button("Submit")

        trip.reload

        expect(trip.duration).to eq(240)
      end
    end

    describe "and update the end date" do
      it "" do
        setup
        visit("/trips")
        first(:link, "Edit").click
        trip = Trip.find(2)

        expect(trip.formatted_end_date).to eq("01/01/2017 11:15:00")

        fill_in("trip[end_date]", :with => "01/01/2017 11:16:00")
        click_button("Submit")

        trip.reload

        expect(trip.formatted_end_date).to eq("01/01/2017 11:16:00")
      end

      it "... which automatically updates the duration" do
        setup
        visit("/trips")
        first(:link, "Edit").click
        trip = Trip.find(2)

        expect(trip.duration).to eq(300)

        fill_in("trip[start_date]", :with => trip.formatted_start_date)
        fill_in("trip[end_date]", :with => "01/01/2017 11:16:00")
        click_button("Submit")

        trip.reload

        expect(trip.duration).to eq(360)
      end
    end

    it "and update the bike id" do
      setup
      visit("/trips")
      first(:link, "Edit").click
      trip = Trip.find(2)

      expect(trip.bike_id).to eq(100)

      fill_in("trip[bike_id]", :with => 200)
      click_button("Submit")

      trip.reload

      expect(trip.bike_id).to eq(200)
    end

    describe "and update the zip code..." do
      it "with a 5 digit string" do
        setup
        visit("/trips")
        first(:link, "Edit").click
        trip = Trip.find(2)

        expect(trip.zip_code).to eq("12345")

        fill_in("trip[zip_code]", :with => "67890")
        click_button("Submit")

        trip.reload

        expect(trip.zip_code).to eq("67890")
      end

      it "with a 4 digit string" do
        setup
        visit("/trips")
        first(:link, "Edit").click
        trip = Trip.find(2)

        expect(trip.zip_code).to eq("12345")

        fill_in("trip[zip_code]", :with => "6789")
        click_button("Submit")

        trip.reload

        expect(trip.zip_code).to eq("06789")
      end

      it "to a blank field" do
        setup
        visit("/trips")
        first(:link, "Edit").click
        trip = Trip.find(2)

        expect(trip.zip_code).to eq("12345")

        fill_in("trip[zip_code]", :with => "")
        click_button("Submit")

        trip.reload

        expect(trip.zip_code).to eq("")
      end
    end
  end
end

def setup
  City.create(name: "Denver")
  Station.create(
    name:              "New Victoria St",
    city_id:           1,
    dock_count:        15,
    installation_date: "8/7/2016"
  )
  Station.create(
    name:              "West Earl Ave",
    city_id:           1,
    dock_count:        22,
    installation_date: "7/8/2016"
  )
  Trip.create(
    duration:          300,
    start_date:        "01/01/2017 10:10:00",
    start_station_id:  1,
    end_date:          "01/01/2017 10:15:00",
    end_station_id:    1,
    bike_id:           100,
    subscription_type: "customer",
    zip_code:          "12345"
  )
  Trip.create(
    duration:          300,
    start_date:        "01/01/2017 11:10:00",
    start_station_id:  1,
    end_date:          "01/01/2017 11:15:00",
    end_station_id:    1,
    bike_id:           100,
    subscription_type: "customer",
    zip_code:          "12345"
  )
end
