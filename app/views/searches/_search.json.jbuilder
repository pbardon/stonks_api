# frozen_string_literal: true

search = search || @search

json.extract! search, :ticker, :date, :updated_at
json.url search_url(search, format: :json)
