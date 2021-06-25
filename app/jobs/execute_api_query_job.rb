class ExecuteApiQueryJob < ApplicationJob
  queue_as :default

  def perform(search_id)
    # Do something later
    search = Search.find(search_id)
    search.query_external_api
    # Associate the search with the company
    search.company = Company.find_by_ticker(search.ticker)
    search.save!
  end
end
