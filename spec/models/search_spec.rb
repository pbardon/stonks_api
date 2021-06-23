# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Search, type: :model do
  describe 'search field validation' do
    it 'is valid with valid attributes' do
      expect(create(:search)).to be_valid
    end

    it 'is not valid without a ticker' do
      search = build(:search)
      # update with invalid attribute returns false
      expect(search.update(ticker: nil)).to be false
      expect(search).to_not be_valid
    end
  end

  describe 'it can query the api for historical price data for a specific company' do
    it 'can query the api and get a result' do
      search = build(:search)
      result = search.query_external_api
      expect(result.class).to eq(Company)
    end
  end

  describe 'it belongs to a single company that we searched for' do
    it 'can create a company associated with the search' do
      c = create(:company)
      c.searches.create(build(:search).attributes)
      expect(c.searches).to_not be_nil
    end

    it 'can be associated with an existing company' do
      c = create(:company)
      s = create(:search)
      s.company = Company.find_by_ticker(c.ticker)
      s.save
      expect(s.company.ticker).to eq(c.ticker)
      expect(c.searches.map(&:id)).to include(s.id)
    end
  end

  describe 'it can query the external api' do
    it 'can retrieve the results from the api' do
      # todo: mock fetch results
      s = create(:search)
      s.query_external_api
      expect(s.date).to_not be_nil
    end
  end

  describe 'it can create or refresh a company' do
    it 'creates the company if it does not exist' do
      s = build(:search)
      s.date = Faker::Date.backward(days: 5)
      og_date = s.date
      s.ticker = "FOO"
      results = Apis::FinancialModelingPrepApi.new(s.ticker, 'foo').find
      s.create_or_refresh_company(results)
      expect(s.date).to_not be_nil
      expect(s.date).to_not eq(og_date)
    end

    it 'refresh the company if it does exist' do
      s = build(:search)
      s.date = Faker::Date.backward(days: 5)
      og_date = s.date
      c = create(:company)
      s.ticker = c.ticker
      results = Apis::FinancialModelingPrepApi.new(c.ticker, 'foo').find
      s.create_or_refresh_company(results)
      expect(s.date).to eq(og_date)
    end
  end

  describe 'it can refresh prices for a company' do
    it 'creates price objects for each price retreived' do
      s = build(:search)
      c = company_with_prices
      s.ticker = c.ticker

      old_results = JSON.parse(File.open(
        "#{Rails.root}/spec/data/aapl_historical.json"
      ).read)

      s.refresh_prices(c, old_results)

      sorted = c.prices.to_a.sort_by(&:date)

      latest_price = sorted.last
      expect(latest_price.date).to eq(Date.parse('2021-06-01'))

      new_results = JSON.parse(File.open(
        "#{Rails.root}/spec/data/aapl_updated_historical.json"
      ).read)

      s.refresh_prices(c, new_results)
      sorted = c.prices.sort_by(&:date)
      new_latest_price = sorted.last

      expect(new_latest_price).to_not eq(latest_price)
      expect(new_latest_price.date).to eq(Date.parse('2021-06-02'))
    end
  end

  describe 'it can process prices' do
    it 'create the relevant price active record entries' do
      c = create(:company)
      s = build(:search)
      expect(c.prices.length).to eq(0)
      s.ticker = c.ticker
      s.save
      results = JSON.parse(File.open(
        "#{Rails.root}/spec/data/aapl_updated_historical.json"
      ).read)
      s.process_prices(c, results)

      expect(c.prices.length).to_not eq(0)
      expect(c.prices.first.class).to eq(Price)
    end
  end

  describe 'it can fetch results for a company' do
    it 'validates that the data matches the expected format' do
      search = build(:search)
      search.fetch_results
    end

    it 'validates that the query is for the correct company' do
      search = build(:search)
      search.fetch_results
    end
  end

  describe 'it checks if a search already exists? or not' do
    it 'validates uniqueness for a specific date and time' do
      s1 = build(:search)
      s1.ticker = "DDD"
      s1.date = Date.today
      s1.save

      s2 = build(:search)
      s2.ticker = "DDD"
      s2.date = Date.today
      expect(s2.exists?).to be true
    end
  end
end
