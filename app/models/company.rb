# frozen_string_literal: true

# Company model used to hold ticker and company information as well as association to prices
class Company < ApplicationRecord
  validates :ticker, presence: true
  validates :ticker, length: { maximum: 5 }

  has_many :searches
  has_many :prices
end
