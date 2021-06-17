# frozen_string_literal: true

json.partial! 'companies/company', company: @company

json.prices do
  json.array!(@company.prices) do |price|
    json.call(price, :id, :open, :close, :high, :low, :volume)
  end
end
