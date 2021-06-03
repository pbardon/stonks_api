# frozen_string_literal: true

json.extract! search, :ticker, :date, :updated_at
json.url search_url(search, format: :json)
