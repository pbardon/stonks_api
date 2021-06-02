class Search < ApplicationRecord
    validates :ticker, presence: true

    validates :ticker, length: {maximum: 5}


    def query_external_api
        ## Execute search, fetch results from API, and return the search object
        # Search result should contain link to the company object

        # Check if we have results for the ticker first, if so return them
        unless does_search_exist?
        # Otherwise fetch the prices from the API
            results = fetch_results()
        end
        # Process the results and save them to active record

        # Return the search result
        self
    end

    def fetch_results
        fmp_api = FinancialModelingPrepAPI.new()
        fmp_api
    end

    def does_search_exist?
        return Search.find(params[:ticker])
    end


    def create_from_results(results)
        
    end
end
