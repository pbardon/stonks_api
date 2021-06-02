class Price < ApplicationRecord
    belongs_to :company, primary_key: :ticker, foreign_key: :company_ticker, class_name: "Company"

    validates :open, presence: true
    validates :close, presence: true
    validates :high, presence: true
    validates :low, presence: true
    validates :volume, presence: true
    validates :timestamp, presence: true
    validates :querytype, presence: true
    validates :querytype, inclusion: { in: %w(24h 60m) }
end
