# frozen_string_literal: true

json.partial! 'companies/company', company: @company

json.prices do
  json.array!(@company.prices.recent) do |price|
    json.call(price, :id, :date, :open, :close, :high, :low, :volume)
  end
end
