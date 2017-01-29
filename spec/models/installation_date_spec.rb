require_relative '../spec_helper'
require 'pry'

RSpec.describe InstallationDate do
  describe 'validations' do
    it 'validates presence of date' do
      date = InstallationDate.create()

      expect(date).to_not be_valid
    end

    it 'is valid with valid parameters' do
      date = InstallationDate.create(installation_date: "1/1/2017")

      expect(date.installation_date).to eq(Date.parse("Jan 1 2017"))
    end

    it 'is not valid with duplicate entries' do
      date_1 = InstallationDate.create(installation_date: "1/1/2017")
      date_2 = InstallationDate.create(installation_date: "1/1/2017")

      expect(date_1).to be_valid
      expect(date_2).to_not be_valid
    end
  end

  describe 'date import' do
    it 'imports correctly with single digit date where month and day are the same' do
      date = InstallationDate.create(installation_date: "1/1/2017")

      expect(date.installation_date).to eq(Date.parse("Jan 1 2017"))
    end

    it 'is valid with valid double digit date where month and day are the same' do
      date = InstallationDate.create(installation_date: "10/10/2017")

      expect(date.installation_date).to eq(Date.parse("Oct 10 2017"))
    end

    it 'switches month and day when importing valid date in m/d/Y format' do
      date = InstallationDate.create(installation_date: "2/4/2017")

      expect(date.installation_date).to_not eq(Date.parse("Feb 4 2017"))
    end

    it 'is nil when importing invalid date in m/d/Y format' do
      date = InstallationDate.create(installation_date: "2/15/2017")

      expect(date.installation_date).to eq(nil)
    end

    it 'is correct when m/d/Y single digit date is parsed before import' do
      formatted = Date.strptime('2/15/2017', '%m/%d/%Y')

      date = InstallationDate.create(installation_date: formatted)

      expect(date.installation_date).to eq(Date.parse("Feb 15 2017"))
    end

    it 'is correct when m/d/Y double digit date is parsed before import' do
      formatted = Date.strptime('11/30/2017', '%m/%d/%Y')

      date = InstallationDate.create(installation_date: formatted)

      expect(date.installation_date).to eq(Date.parse("Nov 30 2017"))
    end
  end
end