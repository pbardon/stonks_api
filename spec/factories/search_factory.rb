require 'faker'

FactoryBot.define do
    factory :search do
        ticker { Faker::Finance.ticker }
        querytype { rand > 0.499 ? "24h": "60m" }
        timestamp { rand(1..100).days.ago }
    end
end