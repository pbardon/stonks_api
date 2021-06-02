json.extract! price, :id, :ticker, :open, :close, :high, :low, :volume, :timestamp, :querytype, :created_at, :updated_at
json.url price_url(price, format: :json)
