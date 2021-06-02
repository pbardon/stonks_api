class Company < ApplicationRecord
    validates :ticker, presence: true, uniqueness: true
    validates :marketcap, presence: true

    has_many :prices, primary_key: :ticker, foreign_key: :company_ticker, class_name: "Price", dependent: :destroy

    self.primary_key = "ticker"
end
