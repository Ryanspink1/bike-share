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
end
