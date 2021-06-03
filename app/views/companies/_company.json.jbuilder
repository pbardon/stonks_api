json.extract! company, :ticker, :created_at, :updated_at
json.url company_url(company, format: :json)

if company.prices
    json.prices do
        json.array! company.prices, :open, :close, :high, :low, :volume, :date
    end
end
