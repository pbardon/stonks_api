require 'faker'

FactoryBot.define do
    factory :company do
        ticker { Faker::Finance.ticker }
        marketcap { Faker::Number.number(digits: 5)}
    end
end