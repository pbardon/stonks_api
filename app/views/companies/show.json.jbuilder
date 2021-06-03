json.partial! "companies/company", company: @company

json.prices do
    json.array!(@company.prices) do |price|
      json.(price, :id, :open, :close, :high, :low, :volume)
    end
  end