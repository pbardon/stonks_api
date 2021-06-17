# frozen_string_literal: true

# Search model used to record searches as well as the associated results
class Search < ApplicationRecord
  validates :ticker, presence: true
  validates :ticker, length: { maximum: 5 }

  belongs_to :company, optional: true

  def query_external_api
    ## Execute search, fetch results from API, and return the search object
    # Search result should contain link to the company object

    # Fetch the prices from the API
    results = fetch_results

    # Process the results and save them to active record
    create_or_refesh_company(results)
  end

  def create_or_refesh_company(results)
    # Create the prices for each historical price in the data set
    # Create the company if it does not exist
    company = Company.find_by_ticker(ticker)
    unless company
      company = Company.new({ ticker: ticker })
      self.date = Date.today
      return false unless company.save
    end

    # Create or update the prices for each historical price in the data set
    refresh_prices(company, results)
    company
  end

  def refresh_prices(company, results)
    # Create the prices for each historical price in the data set
    company.prices.clear
    # Performance bottleneck, open a single transaction for all the prices
    ActiveRecord::Base.transaction do
      results['historical'].each do |price_data|
        price = Apis::FinancialModelingPrepApi.parse_price(price_data)
        company.prices.create!(price)
      end
    end
  end

  def fetch_results
    fmp_api = Apis::FinancialModelingPrepApi.new(ticker)
    results = fmp_api.find
    ticker = results['symbol']
    raise "External API did not return key 'symbol' data" unless ticker
    raise "External API did not return key 'historical' data" unless results['historical']
    raise 'Search results don\'t match search query' unless ticker == self.ticker

    results
  end

  # Checks to see if this search has already been performed
  def exists?
    # We only allow one ticker to be refreshed per day
    !!Search.find_by_ticker_and_date(ticker, Date.today)
  end
end
