class Company < ApplicationRecord
    validates :ticker, presence: true
    validates :marketcap, presence: true

    has_many :prices

    def fetch_historical_price_data
        api = new FinancialModelingPrepAPI()
        
    end
end
