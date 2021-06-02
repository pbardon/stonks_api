class Company < ApplicationRecord
    validates :ticker, presence: true
    validates :marketcap, presence: true
end
