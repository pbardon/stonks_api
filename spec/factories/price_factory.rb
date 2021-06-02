require 'faker'

FactoryBot.define do
    factory :price do
        ticker { Faker::Finance.ticker }
        querytype { rand > 0.499 ? "24h": "60m" }
        timestamp { rand(1..100).days.ago }
        open { Faker::Number.decimal(l_digits: 2) }
        close { Faker::Number.decimal(l_digits: 2) }
        high { Faker::Number.decimal(l_digits: 2) }
        low { Faker::Number.decimal(l_digits: 2) }
        volume { Faker::Number.number(digits: 5)}

        company
    end
end