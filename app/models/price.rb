class Price < ApplicationRecord
    validates :ticker, presence: true
    validates :ticker, length: {maximum: 5}

    validates :open, presence: true
    validates :close, presence: true
    validates :high, presence: true
    validates :low, presence: true
    validates :volume, presence: true
    validates :timestamp, presence: true
    validates :querytype, presence: true
    validates :querytype, inclusion: { in: %w(24h 60m) }
end
