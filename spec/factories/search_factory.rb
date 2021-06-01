require 'faker'

FactoryBot.define do
    factory :search do
        ticker { Faker::Finance.ticker }
        type { rand > 0.499 ? "24hr": "60min" }
        timestamp { rand(1..100).days.ago }
    end
end