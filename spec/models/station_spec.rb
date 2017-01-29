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
end
