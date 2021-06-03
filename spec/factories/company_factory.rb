require 'faker'

FactoryBot.define do
    factory :company do
        ticker { Faker::Finance.ticker }
    end
end

def company_with_prices(price_count: 5)
    FactoryBot.create(:company) do |company|
        FactoryBot.create_list(:price, price_count, company: company)
    end
end

def company_with_searches(search_count: 4)
    FactoryBot.create(:company) do |company|
        FactoryBot.create_list(:search, search_count, company: company)
    end
end