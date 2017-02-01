require_relative '../spec_helper'

RSpec.describe Trip do
  describe 'validations' do
    it 'validates presence of duration' do
      trip = Trip.create(
        start_date: "01/02/2017 11:11",
        start_station_id: 1,
        end_date: "01/03/2017 11:11",
        end_station_id: 2,
        bike_id: 3,
        subscription_type: 'Subscriber'
      )

      expect(trip).to_not be_valid
    end

    it 'validates presence of start_date' do
      trip = Trip.create(
        duration: 45,
        start_station_id: 1,
        end_date: "01/03/2017 11:11",
        end_station_id: 2,
        bike_id: 3,
        subscription_type: 'Subscriber'
      )

      expect(trip).to_not be_valid
    end

    it 'validates presence of start_station_id' do
      trip = Trip.create(
        duration: 45,
        start_date: "01/02/2017 11:11",
        end_date: "01/03/2017 11:11",
        end_station_id: 2,
        bike_id: 3,
        subscription_type: 'Subscriber'
      )

      expect(trip).to_not be_valid
    end

    it 'validates presence of end_date' do
      trip = Trip.create(
        duration: 45,
        start_date: "01/02/2017 11:11",
        start_station_id: 1,
        end_station_id: 2,
        bike_id: 3,
        subscription_type: 'Subscriber'
      )

      expect(trip).to_not be_valid
    end

    it 'validates presence of end_station_id' do
      trip = Trip.create(
        duration: 45,
        start_date: "01/02/2017 11:11",
        start_station_id: 1,
        end_date: "01/03/2017 11:11",
        bike_id: 3,
        subscription_type: 'Subscriber'
      )

      expect(trip).to_not be_valid
    end

    it 'validates presence of bike_id' do
      trip = Trip.create(
        duration: 45,
        start_date: "01/02/2017 11:11",
        start_station_id: 1,
        end_date: "01/03/2017 11:11",
        end_station_id: 2,
        subscription_type: 'Subscriber'
      )

      expect(trip).to_not be_valid
    end

    it 'validates presence of subscription_type' do
      trip = Trip.create(
        duration: 45,
        start_date: "01/02/2017 11:11",
        start_station_id: 1,
        end_date: "01/03/2017 11:11",
        end_station_id: 2,
        bike_id: 3,
      )

      expect(trip).to_not be_valid
    end

    it 'is valid with valid parameters' do
      trip = Trip.create(
        duration: 45,
        start_date: "01/02/2017 11:11",
        start_station_id: 1,
        end_date: "01/03/2017 11:11",
        end_station_id: 2,
        bike_id: 3,
        subscription_type: 'Subscriber'
      )

      expect(trip).to be_valid
    end
  end

  describe "trip data formatting" do
    it "formatts data correctly" do
      City.create(name: "Denver")

      station1 = Station.create(name: "Station Place", city_id: City.find(1).id, dock_count: 15, installation_date: "10/10/2017")

      station2 = Station.create(name: "Beat Street", city_id: City.find(1).id, dock_count: 20, installation_date: "09/09/2016")

      trip = Trip.create(
        duration: 30,
        start_date: "01/02/2017 11:11",
        start_station_id: 1,
        end_date: "01/02/2017 11:50",
        end_station_id: 2,
        bike_id: 233,
        zip_code: 80218,
        subscription_type: 'subscriber'
      )

      trip2 = Trip.create(
        duration: 150,
        start_date: "06/09/2017 9:32:30",
        start_station_id: 1,
        end_date: "06/09/2017 9:35:20",
        end_station_id: 2,
        bike_id: 65,
        zip_code: 80218,
        subscription_type: 'customer'
      )

      trip3 = Trip.create(
        duration: 60,
        start_date: "06/09/2017 9:42:30",
        start_station_id: 1,
        end_date: "06/09/2017 9:45:20",
        end_station_id: 2,
        bike_id: 65,
        zip_code: 80218,
        subscription_type: 'customer'
      )


      expect(trip.formatted_duration).to eq("00:00:30")

      expect(trip.formatted_start_date).to eq("02/01/2017 11:11:00")

      expect(trip.formatted_end_date).to eq("02/01/2017 11:50:00")

      # expect(Trip.average_duration).to eq("00:00:01:30")
      #
      # expect(Trip.longest_ride).to eq("00:00:02:30")
      #
      # expect(Trip.shortest_ride).to eq("00:00:00:30")

      expect(Trip.most_rides_starting.name).to eq(station1.name)

      expect(Trip.most_rides_ending.name).to eq(station2.name)

      expect(Trip.most_ridden_bike).to eq(65)

      expect(Trip.least_ridden_bike).to eq(233)

      expect(Trip.most_rides_on_a_bike).to eq(2)

      expect(Trip.least_rides_on_a_bike).to eq(1)

      expect(Trip.number_of_subscribed).to eq(1)

      expect(Trip.number_of_customers).to eq(2)

      expect(Trip.percentage_of_subscribed).to eq(33)

      expect(Trip.percentage_of_customers).to eq(67)

      expect(Trip.date_with_most_rides).to eq("09/06/2017")

      expect(Trip.date_with_least_rides).to eq("02/01/2017")

      expect(Trip.month_by_month).to eq({"2017/01" => 1, "2017/06" => 2})

    end
  end
end
