# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :price do
    date { rand(10..29).days.ago }
    open { Faker::Number.decimal(l_digits: 2) }
    close { Faker::Number.decimal(l_digits: 2) }
    high { Faker::Number.decimal(l_digits: 2) }
    low { Faker::Number.decimal(l_digits: 2) }
    volume { Faker::Number.number(digits: 5) }

    company
  end
end
