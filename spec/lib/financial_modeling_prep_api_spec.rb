require 'rails_helper'

RSpec.describe Apis::FinancialModelingPrepApi do
  describe('#initialize') do
    before(:all) do
      mock_ticker = 'DDD'
      @api_client = Apis::FinancialModelingPrepApi.new(mock_ticker)
    end
    it('can create the api client') do
      expect(@api_client.ticker).to_not be_nil
      expect(@api_client.url).to_not be_nil
      if ENV['STONKS_SKIP_TEST_REQUESTS']
        skip 'API key not set in container build for security'
      end
      expect(@api_client.api_key_set?).to be true
    end

    it('formats the url correctly') do
      expect(@api_client.url).to match(
        %r'https:\/\/financialmodelingprep.com\/api\/v3\/historical-price-full\/DDD\?apikey=.*'
      )
    end
  end

  describe('#find') do
    before(:each) do
      # mock out Apis::Api query method to return the correct output
      Apis::Api.subclasses.each do |klass|
        allow_any_instance_of(klass).to receive(:query).and_return({})
      end

      mock_ticker = 'DDD'
      @api_client = Apis::FinancialModelingPrepApi.new(mock_ticker)
    end

    it('can query the api') do
      expect(@api_client.find).to eq({})
    end

    it 'should prevent requests over the daily allowed maximum' do
      5.times do
        expect(@api_client.find).to eq({})
      end
      expect(@api_client.find).to be(false)
    end

    it 'should allow additional requests once the count is reset' do
      Apis::FinancialModelingPrepApi.reset_count(0)
      expect(@api_client.find).to be(false)
      Apis::FinancialModelingPrepApi.reset_count
      expect(@api_client.find).to eq({})
    end
  end

  describe('#query') do
    it 'can make a request to the FMP API' do
      if ENV['STONKS_SKIP_TEST_REQUESTS']
        skip 'Outbound request test disabled'
      end
      mock_ticker = 'DDD'
      @api_client = Apis::FinancialModelingPrepApi.new(mock_ticker)
      result = @api_client.find
      expect(result['historical']).to_not be_nil
    end
  end

  describe('#self.parse_price') do
    it 'should parse a single price entry as an object' do
      mock_raw_price_data = JSON.parse('
        {
        "date" : "2021-06-01",
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
        }
      ')

      Apis::FinancialModelingPrepApi.parse_price(mock_raw_price_data)
    end
  end
end
