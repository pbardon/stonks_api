# frozen_string_literal: true

search = search || @search

json.extract! search, :ticker, :date, :search_status, :updated_at
json.url search_url(search, format: :json)
