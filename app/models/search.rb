# frozen_string_literal: true

# Search model used to record searches as well as the associated results
class Search < ApplicationRecord
  validates :ticker, presence: true
  validates :ticker, length: { maximum: 5 }

  belongs_to :company, optional: true

  # Checks to see if this search has already been performed
  def exists?
    # We only allow one ticker to be refreshed per day
    !!Search.find_by_ticker_and_date(ticker, Date.today)
  end

  # Create new entries in the database for any new prices
  # @param [Company] company associated with the results
  # @param [Array] price data for company in list format
  def process_prices(company, price_list)
    price_list.each do |price_data|
      if company.new_price?(price_data)
        price = Apis::FinancialModelingPrepApi.parse_price(price_data)
        company.prices.create!(price)
      end
    end
  end

  ## Execute search, fetch results from API, and return the search object
  def query_external_api
    # Search result should contain link to the company object

    # Fetch the prices from the API
    fmp_api = Apis::FinancialModelingPrepApi.new(ticker, ENV['api_key'])
    results = fmp_api.find

    # Validate the result format
    validate_results(results)

    # Process the results and save them to active record
    self.company = update_company_prices(results['historical'])
    # Return Search result which contains link to the company object
    self
  end

  def refresh_prices(company, price_list)
    # Create the prices for each historical price in the data set
    # Performance bottleneck, open a single transaction for all the prices
    return if company.last_updated_today?

    company.last_query_date = Date.current
    company.save!

    # Performance bottleneck, open a single transaction for all the prices
    ActiveRecord::Base.transaction do
      process_prices(company, price_list)
    end

    company
  end

  # Create the prices for each historical price in the data set
  # @param [Hash<Symbol, String>] parsed JSON result
  def update_company_prices(price_list)
    # Create the company if it does not exist
    company = Company.find_by_ticker(ticker)
    unless company
      company = Company.new({ ticker: ticker })
      self.date = Date.today
      raise "Unable to create company with ticker: #{ticker}" unless company.save
    end

    # Create or update the prices for each historical price in the data set
    refresh_prices(company, price_list)
  end

  def validate_results(results)
    raise "External API did not return key 'symbol' data" unless results['symbol']
    raise "External API did not return key 'historical' data" unless results['historical']
    raise "Search results don't match search query" unless results['symbol'] == ticker
  end

end
