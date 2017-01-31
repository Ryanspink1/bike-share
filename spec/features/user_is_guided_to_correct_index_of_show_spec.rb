# ENV['RACK_ENV'] = 'test'
require_relative '../spec_helper'

describe "When a user submits a form for a new station" do
  it "User is guided to correct index" do
    visit ('/stations/new')

    fill_in('station[name]', :with => 'Beat Street')
    fill_in('city[name]', :with => 'Denver')
    fill_in('station[dock_count]', :with => 10)
    fill_in('station[installation_date]', :with => '20170102')
    click_button("New Station")

    # save_and_open_page
    expect page.has_current_path?('/stations/1')

    within(".station-name") do
      expect(page).to have_content("Beat Street")
    end
    within('.city') do
      expect(page).to have_content("Denver")
    end
    within('.dock') do
      expect(page).to have_content("10")
    end
    within('.install_date') do
      expect(page).to have_content('2017-01-02')
    end
  end
end
