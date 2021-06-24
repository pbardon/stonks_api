# frozen_string_literal: true

# Price used to represent a single daily historical entry
class Price < ApplicationRecord
  validates :open, presence: true
  validates :close, presence: true
  validates :high, presence: true
  validates :low, presence: true
  validates :volume, presence: true
  validates :date, presence: true

  belongs_to :company

  # Supports default view window of 30 days of historical price information
  scope :recent, -> { where('date > ?', 30.days.ago) }

  # Support range query
  scope :between_dates, ->(start_date, end_date) { where('date BETWEEN ? AND ?', start_date, end_date) }
end
