# frozen_string_literal: true

require_relative 'api'
# Create this API client in the Apis module
module Apis
  # Inherit the common methods from the Api class
  class FinancialModelingPrepApi < Apis::Api
    attr_accessor :ticker, :url

    URL_BASE = 'https://financialmodelingprep.com/api/v3/historical-price-full'

    def initialize(ticker)
      @api_key = ENV['FMP_API_KEY']
      @ticker = ticker
      @request_count = 0
      @request_count_key = 'fmp_api_available_daily_requests'
      @cache = RedisCache.new
      FinancialModelingPrepApi.reset_count unless @cache.get(@request_count_key)
      super("#{URL_BASE}/#{@ticker}?apikey=#{@api_key}")
    end

    def find
      # turn the response into a JSON object
      return false if daily_request_limit_exceeded?

      decrement_request_count
      # query the api

      query
    end

    def daily_request_limit_exceeded?
      Integer(@cache.get(@request_count_key)) < 1
    end

    def decrement_request_count
      count = Integer(@cache.get(@request_count_key))
      new_count = count - 1
      @cache.set(@request_count_key, count - 1)
      Rails.logger.info("#{new_count} API requests left today")
    end

    def api_key_set?
      !!@api_key
    end

    # Static methods
    def self.reset_count(count = 5)
      RedisCache.new.set(
        'fmp_api_available_daily_requests',
        count
      )
    end

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
