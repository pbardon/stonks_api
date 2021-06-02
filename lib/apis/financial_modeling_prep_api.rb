class FinancialModelingPrepAPI < API
    def initialize
        super("https://financialmodelingprep.com/api/v3/historical-price-full/AAPL?apikey=487d2890a3d378b278dfcc2fc705cf90")
    end
end