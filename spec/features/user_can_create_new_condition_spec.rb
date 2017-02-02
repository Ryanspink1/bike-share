require_relative '../spec_helper'

describe "When user submits a form" do
  it "they are able to create a new trip" do
    setup2

    visit('/conditions/new')

    fill_in('condition[date]',               :with => "01/02/2017")
    fill_in('condition[max_temperature]',    :with => 80)
    fill_in('condition[min_temperature]',    :with => 50)
    fill_in('condition[mean_temperature]',   :with => 72)
    fill_in('condition[mean_humidity]',      :with => 12)
    fill_in('condition[mean_visibility]',    :with => 80)
    fill_in('condition[mean_wind_speed]',    :with => 5)
    fill_in('condition[mean_precipitation]', :with => 0.5)

    click_button("Submit")
    expect page.has_current_path?('/conditions/1')

    expect(page.all("//td[@class='date']")[0].text).to eq("01/02/2017")
    expect(page.all("//td[@class='max-temperature']")[0].text).to eq("80")
    expect(page.all("//td[@class='min-temperature']")[0].text).to eq("50")
    expect(page.all("//td[@class='mean-temperature']")[0].text).to eq("72")
    expect(page.all("//td[@class='mean-humidity']")[0].text).to eq("12")
    expect(page.all("//td[@class='mean-visibility']")[0].text).to eq("80")
    expect(page.all("//td[@class='mean-wind-speed']")[0].text).to eq("5")
    expect(page.all("//td[@class='mean-precipitation']")[0].text).to eq("0.5")

  end
end

def setup2
  setup
  Trip.create(
    duration:          300,
    start_date:        "01/02/2017 11:10:00",
    start_station_id:  1,
    end_date:          "01/02/2017 11:15:00",
    end_station_id:    1,
    bike_id:           100,
    subscription_type: "customer",
    zip_code:          "12345"
  )
  Trip.create(
    duration:          300,
    start_date:        "01/02/2017 12:10:00",
    start_station_id:  1,
    end_date:          "01/02/2017 12:15:00",
    end_station_id:    1,
    bike_id:           100,
    subscription_type: "customer",
    zip_code:          "12345"
  )
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
    start_date:        "01/01/2017 11:10:00",
    start_station_id:  1,
    end_date:          "01/01/2017 11:15:00",
    end_station_id:    1,
    bike_id:           100,
    subscription_type: "customer",
    zip_code:          "12345"
  )
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
  Trip.create(
    duration:          300,
    start_date:        "01/01/2017 11:10:00",
    start_station_id:  1,
    end_date:          "01/01/2017 11:15:00",
    end_station_id:    1,
    bike_id:           105,
    subscription_type: "customer",
    zip_code:          "12345"
  )
  Trip.create(
    duration:          300,
    start_date:        "01/01/2017 12:10:00",
    start_station_id:  1,
    end_date:          "01/01/2017 12:15:00",
    end_station_id:    1,
    bike_id:           105,
    subscription_type: "customer",
    zip_code:          "12345"
  )
end
