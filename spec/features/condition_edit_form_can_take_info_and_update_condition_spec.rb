ENV["RACK_ENV"] = "test"
require_relative "../spec_helper"

  describe 'When a user visits an edit page' do
    it 'the correct form parameters are presented' do
    setup_condition_edit
    visit ("/conditions/1/edit")

    within("h1") do
      expect page.has_content?("Edit Condition Info")
    end

    expected_headers = ["Condition Date", "Max Temperature", "Min Temperature",
      "Mean Temperature", "Mean Humidity", "Mean Visiblity", "Mean Wind Speed",
      "Mean Precipitation"]

    headers=page.all("label")
    expected_headers.each_with_index do |header, i|
      within(headers[i]) do
        expect page.has_content?(header)
      end
    end
  end

  describe "the user is able to fill out the edit form..." do
    it "and update the date" do
      setup_condition_edit
      visit("/conditions/1/edit")
      condition = Condition.first

      expect page.has_content?("01/01/2017")

      fill_in('condition[date]', :with=> "02/02/2017")
      click_button("Update Condition")

      condition.reload

      expect page.has_content?("02/02/2017")
      expect page.has_current_path?("/condition/1/")
    end

    it "and update the max temperature" do
      setup_condition_edit
      visit("/conditions/1/edit")
      condition = Condition.first

      within("#max-temp") do
        expect page.has_content?(50)
      end

      fill_in('condition[max_temperature]', :with=> 30)
      click_button("Update Condition")

      condition.reload

      expect(condition.max_temperature).to eq(30)
      expect page.has_current_path?("/condition/1/")
    end

    it "and update the min temperature" do
      setup_condition_edit
      visit("/conditions/1/edit")
      condition = Condition.first

      within("#min-temp") do
        expect page.has_content?(10)
      end

      fill_in('condition[min_temperature]', :with=> 15)
      click_button("Update Condition")

      condition.reload

      expect(condition.min_temperature).to eq(15)
      expect page.has_current_path?("/condition/1/")
    end

    it "and update the mean temperature" do
      setup_condition_edit
      visit("/conditions/1/edit")
      condition = Condition.first

      within("#mean-temp") do
        expect page.has_content?(32)
      end

      fill_in('condition[mean_temperature]', :with=> 36)
      click_button("Update Condition")

      condition.reload

      expect(condition.mean_temperature).to eq(36)
      expect page.has_current_path?("/condition/1/")
    end

    it "and update the mean humidity" do
      setup_condition_edit
      visit("/conditions/1/edit")
      condition = Condition.first

      within("#mean-humidity") do
        expect page.has_content?(55)
      end

      fill_in('condition[mean_humidity]', :with=> 11)
      click_button("Update Condition")

      condition.reload

      expect(condition.mean_humidity).to eq(11)
      expect page.has_current_path?("/condition/1/")
    end

    it "and update the mean visibility" do
      setup_condition_edit
      visit("/conditions/1/edit")
      condition = Condition.first

      within("#mean-visibility") do
        expect page.has_content?(2)
      end

      fill_in('condition[mean_visibility]', :with=> 3)
      click_button("Update Condition")

      condition.reload

      expect(condition.mean_visibility).to eq(3)
      expect page.has_current_path?("/condition/1/")
    end

    it "and update the mean wind speed" do
      setup_condition_edit
      visit("/conditions/1/edit")
      condition = Condition.first

      within("#mean-wind_speed") do
        expect page.has_content?(15)
      end

      fill_in('condition[mean_wind_speed]', :with=> 16)
      click_button("Update Condition")

      condition.reload

      expect(condition.mean_wind_speed).to eq(16)
      expect page.has_current_path?("/condition/1/")
    end

    it "and update the mean precipitation" do
      setup_condition_edit
      visit("/conditions/1/edit")
      condition = Condition.first

      within("#mean-precipitation") do
        expect page.has_content?(0.03)
      end

      fill_in('condition[mean_precipitation]', :with=> 0.05)
      click_button("Update Condition")

      condition.reload

      expect(condition.mean_precipitation).to eq(0.05)
      expect page.has_current_path?("/condition/1/")
    end
  end



end



def setup_condition_edit
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
