require 'faker'

FactoryBot.define do
    factory :search do
        ticker { Faker::Finance.ticker }
        date { Date.today }
    end
end