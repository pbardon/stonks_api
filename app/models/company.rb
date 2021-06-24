# frozen_string_literal: true

# Company model used to hold ticker and company information as well as association to prices
class Company < ApplicationRecord
  # Company must have a ticker
  validates :ticker, presence: true
  # Ticker must be 5 characters or less
  validates :ticker, length: { maximum: 5 }

  # Reference to each search for the company
  has_many :searches
  # References to the historical prices for the company
  # Order the price collection using the date field
  has_many :prices, -> { order(date: :asc) }

  # Check if the most recent update was within the last day
  def last_updated_today?
    return false unless last_query_date

    !last_query_date.before?(Date.current)
  end

  # Return the most recent price that we have stored in the DB
  def most_recent_price
    prices.last
  end

  def new_price?(price_data)
    return false unless price_data['date']

    if prices.find_by(date: price_data['date'])
      false
    else
      true
    end
  end
end
