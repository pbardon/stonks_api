json.extract! company, :id, :ticker, :marketcap, :created_at, :updated_at
json.url company_url(company, format: :json)
