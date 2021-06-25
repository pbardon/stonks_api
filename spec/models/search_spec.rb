# frozen_string_literal: true

require 'rails_helper'


RSpec.describe Search, type: :model do
  # Mock out the external API connector class
  let(:api_connector) do
    instance_double(Apis::FinancialModelingPrepApi)
  end

  describe '#validates' do
    before(:each) { @search = build(:search) }
    it 'is valid with valid attributes' do
      expect(create(:search)).to be_valid
    end

    it 'is not valid without a ticker' do
      # update with invalid attribute returns false
      expect(@search.update(ticker: nil)).to be false
      expect(@search).to_not be_valid
    end

    it 'the length of the ticker' do
      @search.update(ticker: 'HELLOWORLD')
      expect(@search).to_not be_valid
    end
  end

  describe '#belongs_to company' do
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

  describe '#exists?' do
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

  describe '#process_prices' do
    it 'create the relevant price active record entries' do
      c = create(:company)
      s = build(:search)
      expect(c.prices.length).to eq(0)
      s.ticker = c.ticker
      s.save
      results = get_mock_price_data('aapl_updated_historical.json')
      s.process_prices(c, results['historical'])

      expect(c.prices.length).to_not eq(0)
      expect(c.prices.first.class).to eq(Price)
    end

    it 'does not update the price if it already exists' do
      s = build(:search)
      c = create(:company)
      mock_price_data = get_mock_price_data('aapl_historical.json')
      price_list = mock_price_data['historical']
      s.process_prices(c, price_list)
      count = c.prices.count
      price_list.append(price_list[0])
      s.process_prices(c, price_list)
      expect(c.prices.count).to eq(count)
      price_list.append(JSON.parse('{
        "date" : "2021-06-02",
        "open" : 125.08,
        "high" : 125.35,
        "low" : 123.95,
        "close" : 124.28,
        "adjClose" : 124.28,
        "volume" : 6.3890796E7,
        "unadjustedVolume" : 6.3890796E7,
        "change" : -0.8,
        "changePercent" : -0.64,
        "vwap" : 124.52667,
        "label" : "June 01, 21",
        "changeOverTime" : -0.0064
      }'))
      s.process_prices(c, price_list)
      expect(c.prices.count).to eq(count + 1)
    end
  end

  describe '#query_external_api' do
    it 'can retrieve the results from the api' do
      historical_prices = JSON.parse(File.open(
        "#{Rails.root}/spec/data/aapl_historical.json"
      ).read)

      s = create(:search)
      s.ticker = s.company.ticker
      historical_prices['symbol'] = s.company.ticker

      allow(Apis::FinancialModelingPrepApi)
        .to receive(:new)
        .and_return(api_connector)

      allow(api_connector)
        .to receive(:find)
        .and_return(historical_prices)
      search = s.query_external_api
      expect(search.date).to_not be_nil
      expect(search.company.last_query_date).to eq(Date.current)
    end
  end

  describe '#refresh_prices' do
    it 'only updates the price if the last query was older' do
      s = build(:search)
      c = build(:company)
      c.last_query_date = 1.day.ago
      s.company = c
      s.save!
      old_results = get_mock_price_data('aapl_historical.json')

      s.refresh_prices(c, old_results['historical'])
      sorted = c.prices
      latest_price = sorted.last
      expect(latest_price.date).to eq(Date.parse('2021-06-01'))

      new_results = get_mock_price_data('aapl_updated_historical.json')

      c.last_query_date = Date.current
      c.save!
      expect(s.refresh_prices(c, new_results['historical'])).to be(false)
      new_latest_price = c.prices.last

      expect(new_latest_price).to eq(latest_price)
      expect(new_latest_price.date).to eq(Date.parse('2021-06-01'))
    end

    it 'adds any new prices to the prices collection' do
      s = build(:search)
      c = build(:company)
      c.last_query_date = 2.days.ago
      s.company = c
      s.save!
      old_results = get_mock_price_data('aapl_historical.json')

      s.refresh_prices(c, old_results['historical'])
      sorted = c.prices
      latest_price = sorted.last
      expect(latest_price.date).to eq(Date.parse('2021-06-01'))

      new_results = get_mock_price_data('aapl_updated_historical.json')
      
      c.last_query_date = 1.day.ago
      c.save!
      s.refresh_prices(c, new_results['historical'])
      new_latest_price = c.prices.last

      expect(new_latest_price).to_not eq(latest_price)
      expect(new_latest_price.date).to eq(Date.parse('2021-06-02'))
    end
  end

  describe '#update_company_prices' do
    it 'creates the company if it does not exist' do
      s = build(:search)
      s.date = Faker::Date.backward(days: 5)
      og_date = s.date
      s.ticker = 'DDD'
      results = get_mock_price_data('aapl_historical.json')
      s.update_company_prices(results['historical'])
      expect(s.date).to_not be_nil
      expect(s.date).to_not eq(og_date)
    end

    it 'refreshes the company if it does exist' do
      s = build(:search)
      s.date = Faker::Date.backward(days: 5)
      og_date = s.date
      c = create(:company)
      s.ticker = c.ticker
      results = get_mock_price_data('aapl_historical.json')
      s.update_company_prices(results['historical'])
      expect(s.date).to eq(og_date)
    end
  end

  describe '#validate_results' do
    it 'validates that the data matches the expected format' do
      search = build(:search)
      mock_results = {}
      expect { search.validate_results(mock_results) }.to raise_exception(
        "External API did not return key 'symbol' data"
      )
    end

    it 'validates that the query is for the correct company' do
      search = build(:search)
      search.ticker = 'NVDA'
      mock_results = { 'historical' => [], 'symbol' => 'NVDA' }
      search.validate_results(mock_results)
      mock_invalid_results = { 'historical' => [], 'symbol' =>'AAPL' }
      expect { search.validate_results(mock_invalid_results) }.to raise_exception(
        "Search results don't match search query"
      )
    end
  end
end
