class Company < ApplicationRecord
    validates :ticker, presence: true
    validates :ticker, length: { maximum: 5}

    has_many :searches
    has_many :prices
end
