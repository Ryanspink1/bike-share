ENV["RACK_ENV"] = "test"
require_relative "../spec_helper"

describe "When user visits the trips index..." do
  it "they see all of the headers" do
    setup_1

    visit("/trips")

    within("h1") do
      expect page.has_content?("Trips")
    end

    expected_headers = ["Start Station", "End Station", "Start Date", "End Date",
      "Duration", "Bike ID", "Subscription Type", "Zip Code", "Action"]

    headers = page.all("th")
    expected_headers.each_with_index do |header, i|
      within(headers[i]) do
        expect page.has_content?(header)
      end
    end
  end

  describe "they see all of the data..." do
    it "for one trip" do
      setup_1
      visit("/trips")

      table_cells = page.all("tr td")
      within(table_cells[0]) do
        expect page.has_content?(Trip.first.start_station)
      end
      within(table_cells[1]) do
        expect page.has_content?(Trip.first.end_station)
      end
      within(table_cells[2]) do
        expect page.has_content?(Trip.first.start_date)
      end
      within(table_cells[3]) do
        expect page.has_content?(Trip.first.end_date)
      end
      within(table_cells[4]) do
        expect page.has_content?(Trip.first.duration)
      end
      within(table_cells[5]) do
        expect page.has_content?(Trip.first.bike_id)
      end
      within(table_cells[6]) do
        expect page.has_content?(Trip.first.subscription_type)
      end
      within(table_cells[7]) do
        expect page.has_content?(Trip.first.zip_code)
      end
      within(table_cells[8]) do
        expect page.find("/[@class='details-button']")
        expect page.find("/[@class='edit-button']")
        expect page.find("/form")
      end
    end

    it "for two trips" do
      setup_2
      visit("/trips")

      table_cells = page.all("tr td")

      within(table_cells[0]) do
        expect page.has_content?(Trip.last.start_station)
      end
      within(table_cells[1]) do
        expect page.has_content?(Trip.last.end_station)
      end
      within(table_cells[2]) do
        expect page.has_content?(Trip.last.start_date)
      end
      within(table_cells[3]) do
        expect page.has_content?(Trip.last.end_date)
      end
      within(table_cells[4]) do
        expect page.has_content?(Trip.last.duration)
      end
      within(table_cells[5]) do
        expect page.has_content?(Trip.last.bike_id)
      end
      within(table_cells[6]) do
        expect page.has_content?(Trip.last.subscription_type)
      end
      within(table_cells[7]) do
        expect page.has_content?(Trip.last.zip_code)
      end
      within(table_cells[8]) do
        expect page.find("/[@class='details-button']")
        expect page.find("/[@class='edit-button']")
        expect page.find("/form")
      end
      within(table_cells[9]) do
        expect page.has_content?(Trip.first.start_station)
      end
      within(table_cells[10]) do
        expect page.has_content?(Trip.first.end_station)
      end
      within(table_cells[11]) do
        expect page.has_content?(Trip.first.start_date)
      end
      within(table_cells[12]) do
        expect page.has_content?(Trip.first.end_date)
      end
      within(table_cells[13]) do
        expect page.has_content?(Trip.first.duration)
      end
      within(table_cells[14]) do
        expect page.has_content?(Trip.first.bike_id)
      end
      within(table_cells[15]) do
        expect page.has_content?(Trip.first.subscription_type)
      end
      within(table_cells[16]) do
        expect page.has_content?(Trip.first.zip_code)
      end
      within(table_cells[17]) do
        expect page.find("/[@class='details-button']")
        expect page.find("/[@class='edit-button']")
        expect page.find("/form")
      end
    end
  end

  describe "they can click on the details link and it takes them to the details page..." do
    it "for one trip" do
      setup_1
      visit("/trips")

      page.all(".details-button")[0].click
      expect page.has_current_path?("/trips/1")
    end
    it "for two trips" do
      setup_2
      visit("/trips")

      page.all(".details-button")[0].click
      expect page.has_current_path?("/trips/2")

      visit("/trips")
      page.all(".details-button")[1].click
      expect page.has_current_path?("/trips/1")
    end
  end

  describe "they can click on the edit link and it takes them to the edit page..." do
    it "for one trip" do
      setup_1
      visit("/trips")
      table_cells = page.all("tr td")
      page.all(".edit-button")[0].click
      expect page.has_current_path?("/trips/1/edit")
    end
    it "for two trips" do
      setup_2
      visit("/trips")
      table_cells = page.all("tr td")

      page.all(".edit-button")[0].click
      expect page.has_current_path?("/trips/2/edit")

      visit("/trips")
      page.all(".edit-button")[1].click
      expect page.has_current_path?("/trips/1/edit")
    end
  end

  describe "they can click on the delete button and it deletes the record..." do
    it "with one trip" do
      setup_1
      visit("/trips")

      page.all(".delete-button")[0].click

      expect page.has_current_path?("/trips")
      expect(page.all("tr td")).not_to be_present
    end
    it "with two trips" do
      setup_2
      visit("/trips")

      page.all(".delete-button")[1].click

      expect(page.all("tr td")[9]).not_to be_present
      expect page.has_current_path?("/trips/1/edit")
    end
  end
end


def setup_2
  setup_1
  Trip.create(
    duration:          300,
    start_date:        "01/01/2017 12:10:00",
    start_station_id:  1,
    end_date:          "01/01/2017 12:15:00",
    end_station_id:    1,
    bike_id:           100,
    subscription_type: "customer",
    zip_code:          "12345"
  )
end

def setup_1
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
    start_date:        "01/01/2017 11:10:00",
    start_station_id:  1,
    end_date:          "01/01/2017 11:15:00",
    end_station_id:    1,
    bike_id:           100,
    subscription_type: "customer",
    zip_code:          "12345"
  )
end
