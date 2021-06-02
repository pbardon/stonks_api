module Apis
    class FinancialModelingPrepApi < Apis::Api
        def initialize(ticker)
            super("https://financialmodelingprep.com/api/v3/historical-price-full/#{ticker}?apikey=487d2890a3d378b278dfcc2fc705cf90")
        end

        def find
            json_file = File.open("#{Rails.root}/spec/data/aapl_historical.json")
            # turn the response into a JSON object
            return JSON.parse(json_file.read())
        end
    end
end
