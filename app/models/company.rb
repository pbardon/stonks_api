# frozen_string_literal: true

# Company model used to hold ticker and company information as well as association to prices
class Company < ApplicationRecord
  validates :ticker, presence: true
  validates :ticker, length: { maximum: 5 }

  has_many :searches
  has_many :prices, -> { order(date: :desc) }

  def most_recent_price
    # Return the most recent price that we have stored
    # sort the prices by date and return the most recent price data
    latest_price = prices.last
    return latest_price.date
  end

  def price_is_new?(price_data)
    price_date = Date.parse(price_data['date'])
    if Price.find_by ticker: ticker, date: price_date
      false
    else
      true
    end
  end
end
