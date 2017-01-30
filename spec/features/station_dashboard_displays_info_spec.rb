ENV['RACK_ENV'] = 'test'
require_relative '../spec_helper'

  describe 'When a user visits the station-dashboard page' do
    it 'displays all data tags' do
      Station.create(name: "Station 1",
                    city_id: City.find_or_create_by(name: "Denver").id,
                    dock_count: 30,
                    installation_date: "4/4/2016")
      visit ('/station-dashboard')

      within("#station_count") do
        expect(page).to have_content("Total count of stations:")
      end

      within("#average_bikes") do
        expect page.has_content?("Average bikes available per station:")
      end

      within("#most_bikes_at_station") do
        expect page.has_content?("Most bikes available at a station:")
      end

      within("#stations_with_most_bikes") do
        expect page.has_content?("Stations where the most bikes are available")
      end

      within("#fewest_bikes_at_station") do
        expect page.has_content?("Fewest bikes available at a station:")
      end

      within("#stations_with_fewest_bikes") do
        expect page.has_content?("Stations where the fewest bikes are available:")
      end

      within("#newest_station") do
        expect page.has_content?("Newest station:")
      end

      within("#oldest_station") do
        expect page.has_content?("Oldest station:")
      end
    end
  end

  describe 'When a user visits the station-dashboard page' do
    it 'displays the correct data for each tag' do
      Station.create(name: "Station 1",
                    city_id: City.find_or_create_by(name: "Denver").id,
                    dock_count: 30,
                    installation_date: "4/4/2016")
      Station.create(name: "Station 2",
                    city_id: City.find_or_create_by(name: "Pawnee").id,
                    dock_count: 20,
                    installation_date: "8/7/2016")
    visit ('/station-dashboard')

    within("#station_count") do
      expect(page).to have_content(2)
    end

    within("#average_bikes") do
      expect page.has_content?(25)
    end

    within("#most_bikes_at_station") do
      expect page.has_content?(30)
    end

    within("#stations_with_most_bikes") do
      expect page.has_content?("Station 1")
    end

    within("#fewest_bikes_at_station") do
      expect page.has_content?(20)
    end

    within("#stations_with_fewest_bikes") do
      expect page.has_content?("Station 2")
    end

    within("#newest_station") do
      expect page.has_content?("Station 2")
    end

    within("#oldest_station") do
      expect page.has_content?("Station 1")
    end
  end
end

  describe 'When a user visits the station-dashboard page' do
    it 'displays info pertaining to actual database entries' do
      Station.create(name: "Station 1",
                    city_id: City.find_or_create_by(name: "Denver").id,
                    dock_count: 30,
                    installation_date: "4/4/2016")
      Station.create(name: "Station 2",
                    city_id: City.find_or_create_by(name: "Pawnee").id,
                    dock_count: 20,
                    installation_date: "8/7/2016")
    visit ('/station-dashboard')

    within("#station_count") do
      expect(page).to_not have_content(3)
    end

    within("#average_bikes") do
      expect(page).to_not have_content(40)
    end

    within("#most_bikes_at_station") do
      expect(page).to_not have_content(15)
    end

    within("#stations_with_most_bikes") do
      expect(page).to_not have_content("Station 3")
    end

    within("#fewest_bikes_at_station") do
      expect(page).to_not have_content(12)
    end

    within("#stations_with_fewest_bikes") do
      expect(page).to_not have_content("Station 6")
    end

    within("#newest_station") do
      expect(page).to_not have_content("Station 40")
    end

    within("#oldest_station") do
      expect(page).to_not have_content("Station 50")
    end
  end
end
