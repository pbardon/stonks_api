json.extract! price, :id, :ticker, :open, :close, :high, :low, :volume, :timestamp, :querytype, :created_at, :updated_at
json.url company_price_url(@company, price, format: :json)
