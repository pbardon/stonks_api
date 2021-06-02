class Search < ApplicationRecord
    validates :ticker, presence: true
    validates :timestamp, presence: true
    validates :querytype, presence: true

    validates :ticker, length: {maximum: 5}
    validates :querytype, inclusion: { in: %w(24h 60m) }


    def create
        ## Execute search, fetch results from API, and return the search object
        # search result should contain link to price object
        self
    end

    def index
        ## Perform any sorting or filtering of the searches, 
        # we should be able to sort the searches by timestamp or ticker
        # We should be able to filter on the same fields 
        self
    end

    def query_daily
        # First we check if the specific combination is found in the price database
        if price_exists?
            return nil
        end
        # If we are looking for a specific daily price we fetch the week's daily 
        # 24hr interval data. Then we store those values to the database 
        # and return the specific daily price we are querying.
    end

    def query_hourly
        # First we check if the specific combination is found in the price database
        if price_exists?
            return nil
        end
        # If we are looking for a specific hourly price we fetch the days hourly 
        # 60m interval data. Then we store those values to the database 
        # and return the specific hourly price we are querying.

    end
end
