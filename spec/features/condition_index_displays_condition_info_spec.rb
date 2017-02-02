ENV["RACK_ENV"] = "test"
require_relative "../spec_helper"
require 'pry'

  describe 'When a user visits the condition index page'do
    it 'they see the condition header' do
      setup_condition_index
      visit("/conditions")

      within("h1") do
        expect page.has_content?("Conditions")
      end

      expected_headers = ["Date", "Max Temperature", "Min Temperature",
         "Mean Temperature", "Mean Humidity", "Mean Visiblity", "Mean Wind Speed",
         "Mean Precipitation"]

      headers = page.all("th")
      expected_headers.each_with_index do |header, i|
        within(headers[i]) do
          expect page.has_content?(header)
        end
      end
    end

    describe "they see all of the data..." do
      it "for one condition" do
        setup_condition_index
        visit("/conditions")

        table_cells = page.all("tr td")
        within(table_cells[0]) do
          expect page.has_content?(Condition.first.date)
        end
        within(table_cells[1]) do
          expect page.has_content?(Condition.first.max_temperature)
        end
        within(table_cells[2]) do
          expect page.has_content?(Condition.first.min_temperature)
        end
        within(table_cells[3]) do
          expect page.has_content?(Condition.first.mean_temperature)
        end
        within(table_cells[4]) do
          expect page.has_content?(Condition.first.mean_humidity)
        end
        within(table_cells[5]) do
          expect page.has_content?(Condition.first.mean_visibility)
        end
        within(table_cells[6]) do
          expect page.has_content?(Condition.first.mean_wind_speed)
        end
        within(table_cells[7]) do
          expect page.has_content?(Condition.first.mean_precipitation)
        end
        within(table_cells[8]) do
          expect page.find("/[@class='details-button']")
        end
        within(table_cells[9]) do
          expect page.find("/[@class='edit-button']")
        end
        within(table_cells[10]) do
          expect page.find("/form")
        end
      end
    end

    it "for two trips" do
      setup_condition_index
      setup_condition_index_2
      visit("/conditions")

      table_cells = page.all("tr td")
      within(table_cells[0]) do
        expect page.has_content?(Condition.first.date)
      end
      within(table_cells[1]) do
        expect page.has_content?(Condition.first.max_temperature)
      end
      within(table_cells[2]) do
        expect page.has_content?(Condition.first.min_temperature)
      end
      within(table_cells[3]) do
        expect page.has_content?(Condition.first.mean_temperature)
      end
      within(table_cells[4]) do
        expect page.has_content?(Condition.first.mean_humidity)
      end
      within(table_cells[5]) do
        expect page.has_content?(Condition.first.mean_visibility)
      end
      within(table_cells[6]) do
        expect page.has_content?(Condition.first.mean_wind_speed)
      end
      within(table_cells[7]) do
        expect page.has_content?(Condition.first.mean_precipitation)
      end
      within(table_cells[8]) do
        expect page.find("/[@class='details-button']")
      end
      within(table_cells[9]) do
        expect page.find("/[@class='edit-button']")
      end
      within(table_cells[10]) do
        expect page.find("/form")
      end
      within(table_cells[11]) do
        expect page.has_content?(Condition.last.date)
      end
      within(table_cells[12]) do
        expect page.has_content?(Condition.last.max_temperature)
      end
      within(table_cells[13]) do
        expect page.has_content?(Condition.last.min_temperature)
      end
      within(table_cells[14]) do
        expect page.has_content?(Condition.last.mean_temperature)
      end
      within(table_cells[15]) do
        expect page.has_content?(Condition.last.mean_humidity)
      end
      within(table_cells[16]) do
        expect page.has_content?(Condition.last.mean_visibility)
      end
      within(table_cells[17]) do
        expect page.has_content?(Condition.last.mean_wind_speed)
      end
      within(table_cells[18]) do
        expect page.has_content?(Condition.last.mean_precipitation)
      end
    end


    describe "they can click on the edit link to" do
      it "navigate to the corresponding edit page" do
        setup_condition_index
        visit('/conditions')

        table_cells = page.all("tr td")
        within(table_cells[9]) do
          find_link("Edit").click
        end

        expect page.has_current_path?('/conditions/1/edit')
      end
    end

    describe "they can click on the details link to" do
      it "navigate to the corresponding show page" do
        setup_condition_index
        visit('/conditions')

        table_cells = page.all("tr td")
        within(table_cells[8]) do
          find_link("Details").click
        end

        expect page.has_current_path?('/conditions/1')
      end
    end

    describe "they can click on the delete link to" do
      it "update index" do
        setup_condition_index
        visit('/conditions')

        table_cells = page.all("tr td")
        within(table_cells[10]) do
          click_button("Delete")
        end

        expect page.has_current_path?('/conditions')
        expect page.should have_no_content("01/01/2017")
      end
    end
  end



def setup_condition_index
  Condition.create(
    date:               "01/01/2017",
    max_temperature:    50,
    min_temperature:    10,
    mean_temperature:   32,
    mean_humidity:      55,
    mean_visibility:    2,
    mean_wind_speed:    15,
    mean_precipitation: 0.03
  )
end

def setup_condition_index_2
  Condition.create(
    date:               "02/02/2017",
    max_temperature:    60,
    min_temperature:    30,
    mean_temperature:   50,
    mean_humidity:      80,
    mean_visibility:    4,
    mean_wind_speed:    5,
    mean_precipitation: 0.1
  )
end
