require 'faker'

FactoryBot.define do
    factory :company do
        ticker { Faker::Finance.ticker }
        marketcap { Faker::Number.number(digits: 5)}
    end
end

def company_with_prices(price_count: 5)
    FactoryBot.create(:company) do |company|
        FactoryBot.create_list(:price, price_count, company: company)
    end
end