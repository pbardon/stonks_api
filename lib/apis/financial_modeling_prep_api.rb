module Apis
    class FinancialModelingPrepApi < Apis::Api
        def initialize(ticker)
            @ticker = ticker
            super("https://financialmodelingprep.com/api/v3/historical-price-full/#{@ticker}?apikey=487d2890a3d378b278dfcc2fc705cf90")
        end

        def find
            json_file = File.open("#{Rails.root}/spec/data/aapl_historical.json")
            # turn the response into a JSON object
            result = JSON.parse(json_file.read())

            result['symbol'] = @ticker

            result
        end


        # Static methods
        def self.parse_price(raw_price_data)
            return {
                open: raw_price_data['open'],
                close: raw_price_data['close'],
                high: raw_price_data['high'],
                low: raw_price_data['low'],
                volume: raw_price_data['volume']
            }
        end
    end
end
