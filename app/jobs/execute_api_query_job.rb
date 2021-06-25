class ExecuteApiQueryJob < ApplicationJob
  queue_as :default

  def perform(search_id)
    begin
      search = Search.find(search_id)
      search.query_external_api
      # Associate the search with the company
      search.company = Company.find_by_ticker(search.ticker)
      search.search_status = :completed
    rescue RuntimeError => e
      Rails.logger.error(e.message)
      search.search_status = :error
    end
    search.save!
  end
end
