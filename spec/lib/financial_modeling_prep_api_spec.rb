require 'rails_helper'

RSpec.describe Apis::FinancialModelingPrepApi do
  describe('initialization') do
    it('can create the api client') do
      mock_api_key = 'foobar'
      mock_ticker = 'DDD'
      api_client = Apis::FinancialModelingPrepApi.new(mock_ticker, mock_api_key)
      expect(api_client.ticker).to_not be_nil
      expect(api_client.url).to_not be_nil
      expect(api_client.api_key_set?).to be true
    end
  end

  describe('can be created as a singleton') do
    # todo: figure out singleton pattern for rails
  end

  # describe('querying the api') do
  #   mock_api_key = 'foobar'
  #   mock_ticker = 'DDD'
  #   api_client = Apis::FinancialModelingPrepApi.new(mock_ticker, mock_api_key)
  #   # mock out Apis::Api get method to return the correct output
  #   result = api_client.find
  # end

  # describe('limiting the number of daily requests') do
  #   it 'should prevent requests over the daily allowed maximum' do
  #     mock_api_key = 'foobar'
  #     mock_ticker = 'DDD'
  #     api_client = Apis::FinancialModelingPrepApi.new(mock_ticker, mock_api_key)
  #     api_client.allowed_daily_requests = 5
  #     5.times do 
  #       expect(api_client.find).to be_nil
  #     end
  #     expect(api_client.find).to be(false)
  #   end
  # end
end
