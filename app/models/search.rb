class Search < ApplicationRecord
    validates :ticker, presence: true
    validates :timestamp, presence: true
    validates :querytype, presence: true

    validates :ticker, length: {maximum: 5}
    validates :querytype, inclusion: { in: %w(24h 60m) }

end
