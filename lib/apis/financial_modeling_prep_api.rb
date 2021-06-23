# frozen_string_literal: true
require_relative 'api'
# Create this API client in the Apis module
module Apis
  # Inherit the common methods from the Api class
  class FinancialModelingPrepApi < Apis::Api
    attr_accessor :ticker, :url
    attr_accessor :allowed_daily_requests

    URL_BASE = 'https://financialmodelingprep.com/api/v3/historical-price-full'

    def initialize(ticker, api_key)
      @api_key = api_key
      @ticker = ticker
      @request_count = 0
      @allowed_daily_requests = 100
      super("#{URL_BASE}/#{@ticker}?apikey=#{@api_key}")
    end

    def render_mock_api
      json_file = File.open("#{Rails.root}/spec/data/aapl_historical.json")
       # turn the response into a JSON object
      return JSON.parse(json_file.read)
    end

    def update_ticker(ticker)
      @ticker = ticker
    end

    def set_url(url)
      @url = url
    end

    def find
      # turn the response into a JSON object
      increment_request_count
      return false if daily_request_limit_exceeded?

      result = render_mock_api
      result['symbol'] = ticker
      result
    end

    def daily_request_limit_exceeded?
      @request_count > @allowed_daily_requests
    end
  
    def increment_request_count
      @request_count += 1
    end
  
    def reset_count
      @request_count = 0
    end

    def api_key_set?
      return !!@api_key
    end

    # Static methods
    def self.parse_price(raw_price_data)
      {
        open: raw_price_data['open'],
        close: raw_price_data['close'],
        high: raw_price_data['high'],
        low: raw_price_data['low'],
        volume: raw_price_data['volume'],
        date: Date.parse(raw_price_data['date'])
      }
    end
  end
end
