require 'faker'

FactoryBot.define do
    factory :search do
        ticker { Faker::Finance.ticker }
        date { Date.today }
        company
    end
end