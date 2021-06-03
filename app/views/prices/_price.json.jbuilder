json.extract! price, :id, :open, :close, :high, :low, :volume, :date, :created_at, :updated_at
json.url company_price_url(@company, price, format: :json)
