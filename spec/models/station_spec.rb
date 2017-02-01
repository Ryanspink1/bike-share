require_relative '../spec_helper'

RSpec.describe Station do
  describe 'validations' do
    it 'validates presence of name' do
      station = Station.create(
        city: City.create(name: "New Victoria"),
        dock_count: 1,
        installation_date: 1
      )

      expect(station).to_not be_valid
    end

    it 'validates presence of city' do
      station = Station.create(
        name: "Blick & Lock",
        dock_count: 1,
        installation_date: 1
      )

      expect(station).to_not be_valid
    end

    it 'validates presence of dock_count' do
      station = Station.create(
        name: "Blick & Lock",
        city: City.create(name: "New Victoria"),
        installation_date: 1
      )

      expect(station).to_not be_valid
    end

    it 'validates presence of installation_date' do
      station = Station.create(
        name: "Blick & Lock",
        city: City.create(name: "New Victoria"),
        dock_count: 1
      )

      expect(station).to_not be_valid
    end

    it 'is valid with valid parameters' do
      station = Station.create(
        name: "Blick & Lock",
        city: City.create(name: "New Victoria"),
        dock_count: 1,
        installation_date: '1/1/2017'
      )

      expect(station).to be_valid
    end
  end

  describe 'installation_date format' do


    describe 'date import' do
      it 'imports correctly with single digit date where month and day are the same' do
        station = Station.create(
          name: "Blick & Lock",
          city: City.create(name: "New Victoria"),
          dock_count: 1,
          installation_date: "1/1/2017"
        )

        expect(station.installation_date).to eq(Date.parse("Jan 1 2017"))
      end

      it 'is valid with valid double digit date where month and day are the same' do
        station = Station.create(
          name: "Blick & Lock",
          city: City.create(name: "New Victoria"),
          dock_count: 1,
          installation_date: "10/10/2017"
        )

        expect(station.installation_date).to eq(Date.parse("Oct 10 2017"))
      end

      it 'switches month and day when importing valid date in m/d/Y format' do
        station = Station.create(
          name: "Blick & Lock",
          city: City.create(name: "New Victoria"),
          dock_count: 1,
          installation_date: "2/4/2017"
        )

        expect(station.installation_date).to_not eq(Date.parse("Feb 4 2017"))
      end

      it 'is nil when importing invalid date in m/d/Y format' do
        station = Station.create(
          name: "Blick & Lock",
          city: City.create(name: "New Victoria"),
          dock_count: 1,
          installation_date: "2/15/2017"
        )

        expect(station.installation_date).to eq(nil)
      end

      it 'is correct when m/d/Y single digit date is parsed before import' do
        formatted = Date.strptime('2/15/2017', '%m/%d/%Y')

        station = Station.create(
          name: "Blick & Lock",
          city: City.create(name: "New Victoria"),
          dock_count: 1,
          installation_date: formatted
        )

        expect(station.installation_date).to eq(Date.parse("Feb 15 2017"))
      end

      it 'is correct when m/d/Y double digit date is parsed before import' do
        formatted = Date.strptime('11/30/2017', '%m/%d/%Y')
        station = Station.create(
          name: "Blick & Lock",
          city: City.create(name: "New Victoria"),
          dock_count: 1,
          installation_date: formatted
        )

        expect(station.installation_date).to eq(Date.parse("Nov 30 2017"))
      end
    end
  end
  describe "station methods" do
    it "do accurate analysis" do
      date = "01/27/2016 09:30"
      date2= "01/27/2016 09:32"

      date3="02/25/2015 10:48"
      date4="02/25/2015 10:50"

      Trip.create(duration: 145, start_date: Date.strptime(date, "%m/%d/%Y %H:%M"),
      start_station_id: 1, end_date: Date.strptime(date2, "%m/%d/%Y %H:%M"),
      end_station_id: 2, bike_id: 12, subscription_type: "Subscribed",
      zip_code: 80218)

      Trip.create(duration: 145, start_date: Date.strptime(date, "%m/%d/%Y %H:%M"),
      start_station_id: 1, end_date: Date.strptime(date2, "%m/%d/%Y %H:%M"),
      end_station_id: 2, bike_id: 12, subscription_type: "Subscribed",
      zip_code: 80218)

      Trip.create(duration: 145, start_date: Date.strptime(date3, "%m/%d/%Y %H:%M"),
      start_station_id: 2, end_date: Date.strptime(date4, "%m/%d/%Y %H:%M"),
      end_station_id: 1, bike_id: 12, subscription_type: "Subscribed",
      zip_code: 80215)

      City.create(name: "Denver")

      station1 = Station.create(name: "Station Place", city_id: City.find(1).id, dock_count: 15, installation_date: "10/10/2017")

      station2 = Station.create(name: "Beat Street", city_id: City.find(1).id, dock_count: 20, installation_date: "09/09/2016")

      expect(Station.average_bikes_per_station).to eq(18)

      expect(Station.with_most_bikes.first.name).to eq("Beat Street")

      expect(Station.with_fewest_bikes.first.name).to eq("Station Place")

      expect(station1.most_frequent_destination_station.name).to eq("Beat Street")

      expect(station2.most_frequent_starting_station.name).to eq("Station Place")

      expect(station1.most_frequent_zip).to eq("80218")

      expect(station1.most_frequent_bike).to eq(12)

      expect(station1.date_with_highest_number_of_trips).to eq("2016-01-27")
    end
  end
end
